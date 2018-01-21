defmodule PhoenixTweeterStream.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_tweeter_stream,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  def application do
    [mod: {PhoenixTweeterStream, []},
     applications: [:phoenix, :cowboy, :logger]]
  end

  defp deps do
    [
      {:phoenix, "~> 0.8.0"},
      {:cowboy, "~> 1.0"},
      {:oauth, github: "tim/erlang-oauth"},
      {:extwitter, "~> 0.1"}
    ]
  end
end
