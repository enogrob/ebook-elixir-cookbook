defmodule Redis.MsgPusher do

  def send(msg) do
    case msg do
      {:message, _, extracted_msg, _} ->
        IO.puts "#{log_time} [REDIS Msg Received] #{inspect msg}"
        Postgres.Db.save_message(extracted_msg)
      _ ->
    end
  end

  defp log_time do
    {{year, month, day}, {hour, minute, second}} = :erlang.now |> :calendar.now_to_local_time
    "[#{year}/#{month}/#{day} #{hour}:#{minute}:#{second}]"
  end

end
