defmodule RedisAndPostgresql.Mixfile do
  use Mix.Project

  def project do
    [app: :redis_and_postgresql,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :postgrex, :ecto],
     mod: {RedisAndPostgresql, []}]
  end

  defp deps do
    [
      { :exredis, github: "artemeff/exredis", tag: "0.1.0" },
      { :postgrex, "~> 0.7.0" },
      { :ecto, "~> 0.7.1" }
    ]
  end
end
