defmodule SvgSprite do
  @moduledoc """
  > Want the wonderful goodness of SVG without having the need for our SVG + JS framework at the moment? Have no fear, SVG Sprites are here. We have lovingly prepped all the icon set styles into their own SVG sprites.

  This quote is taken from the Font Awesome documentation about [SVG sprites](https://fontawesome.com/how-to-use/on-the-web/advanced/svg-sprites). I love the Font Awesome icons, but I'm not particularly eager to use their JavaScript code, the CSS files or the webfont. So the "big" SVG sprite files provided by this library are just the perfect solution for me.

  SvgSprite helps you to embed these SVG sprites in your Phoenix template. Instead of writing verbose code like this:

  ```html
  <a href="https://facebook.com/fontawesome">
    <svg fill="currentColor" class="w-5 h-5">
      <use xlink:href="/images/brands.svg#facebook"></use>
    </svg>
  </a>
  ```

  It is much nicer to just write.

  ```html
  <a href="https://facebook.com/fontawesome">
    <%= icon("brands", "facebook", class: "w-5 h-5") %>
  </a>
  ```

  Or use atoms for the icon family and name.

  ```html
  <a href="https://facebook.com/fontawesome">
    <%= icon(:brands, :facebook, class: "w-5 h-5") %>
  </a>
  ```

  This library is inspired by Font Awesome but it is not limited to it. Basically, it expects a SVG sprite file inside a base path which contains all the symbols. Every symbol has to have a unique name as its HTML id attribute.

  The example above expects a file named `brands.svg` inside your `images` static path. Inside this file a symbol with the id `facebook` has to exist.

  ## Installation

  Attrition can be installed by adding `attrition` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
  [
    {:svg_sprite, "~> 0.1.0"}
  ]
  end
  ```

  ### Fetch the dependencies

  ```shell
  mix deps.get
  ```

  ## Setup

  Setup for attrition can be accomplished in two easy steps!

  ### 1. Import SvgSprite inside your view_helpers

  Of course you could add the library to every view manually by adding `import SvgSprite`. A better solution is to add it to the `view_helpers` function in inside your `application_web.ex` file.

  ```elixir
  defp view_helpers do
    quote do
      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      # Import LiveView helpers (live_render, live_component, live_patch, etc)
      import Phoenix.LiveView.Helpers

      # Import basic rendering functionality (render, render_layout, etc)
      import Phoenix.View

      import SvgSprite
      ...
    end
  end
  ```

  ### (Optional) 2. Environment Configuration

  As mentioned above, the library searches per default inside the images path inside your static assets folder. But you can change the base path inside your `config.exs` file.

  ```elixir
  config :svg_sprite,
    base_path: "/images"
  ```

  Of course you can also host the SVG sprites on some kind of CDN.

  ```elixir
  config :svg_sprite,
    base_path: "https://cdn.mycompany.com/svg/sprites"
  ```

  ## Font Awesome specific features

  Normally, Font Awesome uses short names for the icon family like fas, far, fab, etc. in its documentation. And the icon names always have a "fa-" as a prefix.

  SvgSprite maps the short names to the long names of the SVG sprite files.

  | Short Name |  Long Name |  Filename   |
  | ---------- | ---------- | ----------- |
  | fas        | solid      | solid.svg   |
  | far        | regular    | regular.svg |
  | fab        | brands     | brands.svg  |
  | fal        | light      | light.svg   |
  | fad        | duotone    | duotone.svg |

  It also removes the "fa-" prefix, because inside the SVG sprite files the names are used without the prefix. The following statements are all equivalent.

  ```erb
  <%= icon("brands", "facebook", class: "w-5 h-5") %>
  <%= icon("fab", "fa-facebook", class: "w-5 h-5") %>
  <%= icon("brands", "fa-facebook", class: "w-5 h-5") %>
  <%= icon("fab", "facebook", class: "w-5 h-5") %>
  ```
  """

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
