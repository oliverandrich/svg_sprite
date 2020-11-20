defmodule SvgSprite.MixProject do
  use Mix.Project

  @repo_url "https://github.com/oliverandrich/svg_sprite"
  @version "0.1.1"

  def project do
    [
      app: :svg_sprite,
      version: @version,
      elixir: "~> 1.10",
      description: description(),
      package: package(),
      deps: deps(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      name: "SvgSprite",
      source_url: @repo_url,
      homepage_url: @repo_url,
      docs: [
        main: "SvgSprite",
        api_reference: false,
        source_ref: @version,
        extras: ["README.md"],
        extra_section: []
      ]
    ]
  end

  defp description do
    """
    SvgSprite provides a helper to embed SVG sprites inside your Phoenix HTML templates.
    """
  end

  defp package do
    [
      name: :svg_sprite,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Oliver Andrich, oliver@andrich.me"],
      licenses: ["MIT"],
      links: %{"GitHub" => @repo_url}
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:phoenix_html, "~> 2.14"},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false, optional: true},
      {:ex_doc, ">= 0.0.0", only: [:release, :dev], runtime: false}
    ]
  end
end
