defmodule RedisAndPostgresql do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Redis.Subscriber, []),
      worker(Postgres.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: RedisAndPostgresql.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
