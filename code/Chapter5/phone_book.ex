defmodule PhoneBook do

  @name __MODULE__

  def start_link do
    Agent.start_link(fn -> %{} end, name: @name)
  end

  def insert(user, number) do
    Agent.update(@name, &Map.put(&1, user, number))
  end

  def get(user) do
    Agent.get(@name, &Map.get(&1, user))
  end

end
