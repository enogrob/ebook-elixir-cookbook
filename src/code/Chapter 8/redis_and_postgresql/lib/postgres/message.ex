defmodule Postgres.Message do
  use Ecto.Model

  schema "messages" do
    field :message_from,        :string
    field :message_to,          :string
    field :message_text,        :string
  end

end
