defmodule Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def up do
    "CREATE TABLE IF NOT EXISTS messages(id serial primary key, message_from text, message_to text, message_text text)"
  end

  def down do
    "DROP TABLE messages"
  end
end
