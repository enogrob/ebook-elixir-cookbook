defmodule CowboyApp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Cowboy.Dispatch.start

    children = [
      # Define workers and child supervisors to be supervised
      # worker(CowboyApp.Worker, [arg1, arg2, arg3])
    ]

    opts = [strategy: :one_for_one, name: CowboyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
