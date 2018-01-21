defmodule SupervisedApp.Mixfile do
  use Mix.Project

  def project do
    [app: :supervised_app,
     version: "0.0.1",
     elixir: "~> 0.15.1",
     deps: deps]
  end

  def application do
    [applications: [:logger],
     mod: {SupervisedApp, []}]
  end

  defp deps do
    []
  end
end
