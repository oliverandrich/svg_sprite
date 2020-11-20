defmodule SvgSprite do
  @external_resource readme = "README.md"
  @moduledoc readme
             |> File.read!()
             |> String.split("<!-- MDOC !-->")
             |> Enum.fetch!(1)

  import Phoenix.HTML.Tag

  @base_path Application.get_env(:svg_sprite, :base_path, "/images/")
             |> String.trim_trailing("/")

  @doc """
  Creates an SVG tag which references a SVG sprite from an external SVG sprite file and returns it
  as a :safe HTML string.
  """
  def icon(family, icon, opts \\ [])

  # convert symbols to strings
  def icon(family, icon, opts) when is_atom(family), do: icon(Atom.to_string(family), icon, opts)
  def icon(family, icon, opts) when is_atom(icon), do: icon(family, Atom.to_string(icon), opts)

  # translate from icon family shortname to longname
  def icon("fas", icon, opts), do: icon("solid", icon, opts)
  def icon("far", icon, opts), do: icon("regular", icon, opts)
  def icon("fab", icon, opts), do: icon("brands", icon, opts)
  def icon("fal", icon, opts), do: icon("light", icon, opts)
  def icon("fad", icon, opts), do: icon("duotone", icon, opts)

  # strip the fa- prefix from the icon name
  def icon(family, "fa-" <> icon, opts), do: icon(family, icon, opts)

  def icon(family, icon, opts) do
    opts = Keyword.update(opts, :fill, "currentColor", &Function.identity/1)
    content_tag(:svg, use_tag(family, icon), opts)
  end

  defp use_tag(family, icon) do
    content_tag(:use, "", href: @base_path <> "/" <> family <> ".svg#" <> icon)
  end
end
