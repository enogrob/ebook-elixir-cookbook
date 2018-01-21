defmodule SupervisedApp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(SupervisedApp.Worker, [arg1, arg2, arg3])
    ]

    opts = [strategy: :one_for_one, name: SupervisedApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
