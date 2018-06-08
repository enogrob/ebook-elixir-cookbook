defmodule Messages do

  def start_link do
    {:ok, spawn_link(fn -> wait_for_messages() end)}
  end


  defp wait_for_messages() do
    receive do
      {"ping", caller} ->
        IO.puts "So ping to you too!"
        send caller, "ping"
        wait_for_messages()

      {"pong", caller} ->
        IO.puts "So pong to you too!"
        send caller, "pong"
        wait_for_messages()

      {_, caller} ->
        IO.puts "What do you mean? I'm only listening to pings and pongs!"
        send caller, "what?"
        wait_for_messages()
    end
  end

end
