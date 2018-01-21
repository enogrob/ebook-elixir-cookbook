use Mix.Config

config :redis_and_postgresql, Postgres.Repo,
  database: "elixir_cookbook",
  username: "paulo",
  password: "",
  hostname: "localhost"
