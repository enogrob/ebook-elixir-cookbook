defmodule PhoenixTweeterStream.Endpoint do
  use Phoenix.Endpoint, otp_app: :phoenix_tweeter_stream

  plug Plug.Static,
    at: "/", from: :phoenix_tweeter_stream

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_phoenix_tweeter_stream_key",
    signing_salt: "4blL48Of",
    encryption_salt: "zq+jX2ZX"

  plug :router, PhoenixTweeterStream.Router
end
