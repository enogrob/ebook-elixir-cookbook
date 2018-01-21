defmodule Todo do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      worker(Todo.Endpoint, []),
      worker(Todo.AccessCounter, [])

    ]

    opts = [strategy: :one_for_one, name: Todo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Todo.Endpoint.config_change(changed, removed)
    :ok
  end
end
