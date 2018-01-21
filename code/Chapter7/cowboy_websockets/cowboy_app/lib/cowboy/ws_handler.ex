defmodule Cowboy.WsHandler do

  @behaviour :cowboy_websocket_handler

  def init({:tcp, :http}, _req, _opts) do
    {:upgrade, :protocol, :cowboy_websocket}
  end

  def websocket_init(_transport_name, req, _opts) do
    Cowboy.WsServer.join(self())
    {:ok, req, :undefinded_state}
  end

  def websocket_handle({:text, msg}, req, state) do
    # change :others to :all if you wish to notify the sender too!
    Cowboy.WsServer.send_messages(:others, self(), msg)
    {:ok, req, state}
  end
  def websocket_handle(_data, req, state) do
    {:ok, req, state}
  end

  def websocket_info({:send_message, _server_pid, msg}, req, state) do
    {:reply, {:text, msg}, req, state}
  end
  def websocket_info(_info, req, state) do
    {:ok, req, state}
  end

  def websocket_terminate(_reason, _req, _state) do
    Cowboy.WsServer.leave(self())
    :ok
  end

end
