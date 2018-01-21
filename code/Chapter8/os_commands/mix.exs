defmodule OsCommands.Mixfile do
  use Mix.Project

  def project do
    [app: :os_commands,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :porcelain]]
  end

  defp deps do
    [{:porcelain, "~> 2.0"}]
  end
end
