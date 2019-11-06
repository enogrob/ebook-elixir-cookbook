defmodule Mix.Tasks.Meminfo do
  use Mix.Task
  @shortdoc "Get Erlang VM memory usage information"
  @moduledoc """
A mix custom task that outputs some information regarding
the Erlang VM memory usage
"""
  def run(_) do
    meminfo = :erlang.memory
    IO.puts """
    Total            #{meminfo[:total]}
    Processes        #{meminfo[:processes]}
    Processes (used) #{meminfo[:processes_used]}
    System           #{meminfo[:system]}
    Atom             #{meminfo[:atom]}
    Atom (used)      #{meminfo[:atom_used]}
    Binary           #{meminfo[:binary]}
    Code             #{meminfo[:code]}
    ETS              #{meminfo[:ets]}
    """
  end
end
