defmodule Bundesbank.MixProject do
  use Mix.Project

  @version "0.1.4"

  def project do
    [
      app: :bundesbank,
      version: @version,
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      name: "Bundesbank",
      source_url: "https://github.com/daskycodes/bundesbank",
      deps: deps(),
      docs: docs(),
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
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:nimble_csv, "~> 0.7"}
    ]
  end

  defp description do
    """
    A collection of German Bank Data including BIC, Bankcodes, PAN and more useful information based on the Bundesbank Data Set
    """
  end

  defp docs do
    [
      main: "Bundesbank",
      source_ref: "v#{@version}",
      source_url: "https://github.com/daskycodes/bundesbank"
    ]
  end

  defp package() do
    [
      maintainers: ["Daniel Khaapamyaki"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/daskycodes/bundesbank"}
    ]
  end
end
