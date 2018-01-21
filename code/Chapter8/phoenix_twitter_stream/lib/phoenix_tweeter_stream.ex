defmodule PhoenixTweeterStream do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    ExTwitter.configure(
      consumer_key: System.get_env("SMM_TWITTER_CONSUMER_KEY"),
      consumer_secret: System.get_env("SMM_TWITTER_CONSUMER_SECRET"),
      access_token: System.get_env("SMM_TWITTER_ACCESS_TOKEN"),
      access_token_secret: System.get_env("SMM_TWITTER_ACCESS_TOKEN_SECRET")
    )

    children = [
      # Start the endpoint when the application starts
      worker(PhoenixTweeterStream.Endpoint, []),

      # Here you could define other workers and supervisors as children
      # worker(PhoenixTweeterStream.Worker, [arg1, arg2, arg3]),
    ]

    opts = [strategy: :one_for_one, name: PhoenixTweeterStream.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    PhoenixTweeterStream.Endpoint.config_change(changed, removed)
    :ok
  end
end
