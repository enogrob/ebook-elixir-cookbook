defmodule Redis.Subscriber do

  use GenServer
  use Exredis
  require Record
  Record.defrecord :state, [client: nil, client_sub: nil]

  @server               __MODULE__
  @redis_url            "127.0.0.1"
  @redis_port           "6379"
  @notification_channel "elixir_cookbook"
  @name                 :pubsub

  def start_link do
    :gen_server.start_link({:local, @server}, __MODULE__, [], [])
  end

  def init(_options\\[]) do
    client_sub = Exredis.Sub.start
    client = Exredis.start_using_connection_string("redis://#{@redis_url}:#{@redis_port}")
    :global.register_name(@name, client)
    _pid = Kernel.self
    state = state(client: client, client_sub: client_sub)
    # Register the subscriber function
    client_sub |> Exredis.Sub.subscribe @notification_channel, fn(msg) -> Redis.MsgPusher.send(msg) end
    {:ok, state}
  end

  def terminate(_reason, state) do
    # close redis connection
    client_sub = :erlang.list_to_pid(state.client_sub)
    client_sub |> Exredis.Sub.stop
    client = :erlang.list_to_pid(state.client)
    client |> Exredis.stop
    :ok
  end

end
