defmodule ConnectionTracker do

  use GenServer

  ## Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def add_user(server, message) do
    GenServer.cast(server, {:add, message})
  end

  def search_user(server, ip) do
    GenServer.call(server, {:search, ip})
  end

  ## Callbacks (Server API)
  def init(:ok) do
    {:ok, HashDict.new}
  end

  def handle_cast({:add, message}, connection_dict) do
    {ip, uuid} = message
    if HashDict.get(connection_dict, message) do
      {:noreply, connection_dict}
    else
      {:noreply, HashDict.put(connection_dict, ip, uuid)}
    end
  end

  def handle_call({:search, ip}, _from, connection_dict) do
    {:reply, HashDict.fetch(connection_dict, ip), connection_dict}
  end

end
