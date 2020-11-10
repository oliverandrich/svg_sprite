defmodule SvgSprite.MixProject do
  use Mix.Project

  def project do
    [
      app: :svg_sprite,
      version: "0.1.0",
      elixir: "~> 1.10",
      description: description(),
      package: package(),
      deps: deps(),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      name: "SvgSprite",
      source_url: "https://github.com/oliverandrich/svg_sprite",
      homepage_url: "https://github.com/oliverandrich/svg_sprite",
      docs: [
        main: "SvgSprite",
        extras: ["README.md"]
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
      links: %{"GitHub" => "https://github.com/oliverandrich/svg_sprite"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_html, "~> 2.14"},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false, optional: true},
      {:ex_doc, "~> 0.21", only: [:release, :dev]}
    ]
  end
end
