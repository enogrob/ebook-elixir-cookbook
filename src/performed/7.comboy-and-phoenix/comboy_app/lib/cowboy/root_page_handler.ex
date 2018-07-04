defmodule Cowboy.RootPageHandler do
 def init(_transport, req, []) do
  {:ok, req, nil}
 end

 def handle(req, state) do
  {:ok, req} = :cowboy_req.chunked_reply(200, req)
  :ok = :cowboy_req.chunk("Root page text rendered by handler. No file defining this content!\r\n", req)
  {:ok, req, state}
 end
 
 def terminate(_reason, _req, _state), do: :ok
end
