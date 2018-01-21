defmodule CowboyApp.Mixfile do
  use Mix.Project

  def project do
    [app: :cowboy_app,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :cowboy],
     mod: {CowboyApp, []}]
  end

  defp deps do
    [
      { :cowboy, "~> 1.0.0" }
    ]
  end
end
