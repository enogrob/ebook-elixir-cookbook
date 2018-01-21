defmodule MessagesWithState do
  def start_link do
    {:ok, spawn_link(fn -> wait_for_messages(0,0,0) end)}
  end

  defp wait_for_messages(pings, pongs, unknown) do
    receive do
      {"ping", caller} ->
        send caller, "pong"
        IO.puts "Received #{pings + 1} ping messages!"
        wait_for_messages(pings + 1, pongs, unknown)

      {"pong", caller} ->
        send caller, "pong"
        IO.puts "Received #{pongs + 1} pong messages!"
        wait_for_messages(pings, pongs + 1, unknown)

      {:status, _caller} ->
        IO.puts "Current status: #{pings} pings, #{pongs} pongs and #{unknown} unknown messages."

      {_, caller} ->
        IO.puts "What do you mean? I have received #{unknown + 1} unknown messages!"
        send caller, "unknown"
        wait_for_messages(pings, pongs, unknown + 1)
    end
  end
end
