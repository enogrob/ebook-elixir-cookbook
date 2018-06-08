use Mix.Config

config :phoenix_tweeter_stream, PhoenixTweeterStream.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

# Print only warnings and errors during test
config :logger, level: :warn