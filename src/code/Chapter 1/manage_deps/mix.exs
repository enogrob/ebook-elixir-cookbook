defmodule ManageDeps.Mixfile do
  use Mix.Project

  def project do
    [app: :manage_deps,
     version: "0.0.1",
     elixir: "~> 0.15.1",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [ {:httpoison, "~> 0.4"} ]
  end
end
