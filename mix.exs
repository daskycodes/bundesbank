defmodule Bundesbank.MixProject do
  use Mix.Project

  def project do
    [
      app: :bundesbank,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :yamerl]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:yamerl, "~> 0.7"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
    ]
  end

  defp description do
    """
    A collection of German Bank Data including BIC, Bankcodes, PAN and more useful information based on the Bundesbank Data Set
    """
  end

  defp package do
    [
      maintainers: ["Daniel Khaapamyaki"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/daskycodes/bundesbank"}
    ]
  end
end
