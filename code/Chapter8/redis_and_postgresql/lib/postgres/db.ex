defmodule Postgres.Db do
  import Ecto.Query, only: [from: 2]

  # alias to allow use of the struct
  # module that defines schema is Postgres.Message and not just Message
  alias Postgres.Message

  # message will arrive as a string
  def save_message(message) when is_binary message do
    # message must be converted to a map
    [message_from, message_to, message_text] = String.split(message, ",")
    msg = %Message{message_from: message_from, message_to: message_to, message_text: message_text}
    Postgres.Repo.insert(msg)
  end

  def messages_from(from) do
    query = from m in Message, where: m.message_from == ^from
    Postgres.Repo.all(query)
  end

  def messages_to(to) do
    query = from m in Message, where: m.message_to == ^to
    Postgres.Repo.all(query)
  end

end
