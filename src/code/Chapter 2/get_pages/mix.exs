defmodule GetPages.Mixfile do
  use Mix.Project

  def project do
    [app: :get_pages,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.4"}
    ]
  end
end
