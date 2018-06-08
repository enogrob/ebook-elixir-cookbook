defmodule ReleaseMe do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(ReleaseMe.ConnectionTracker, [])
    ]

    opts = [strategy: :one_for_one, name: ReleaseMe.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
