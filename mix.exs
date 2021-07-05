defmodule OpentelemetryTesla.MixProject do
  use Mix.Project

  def project do
    [
      app: :opentelemetry_tesla,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:tesla, "~> 1.4.1"},
      {:opentelemetry_api, "~> 1.0.0-rc"},
      {:opentelemetry, "~> 1.0.0-rc"},
      {:ex_doc, "~> 0.24.0", only: [:dev], runtime: false},
    ]
  end
end
