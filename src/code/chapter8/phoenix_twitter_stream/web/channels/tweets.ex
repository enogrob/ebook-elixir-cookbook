defmodule PhoenixTwitterStream.Channels.Tweets do
  use Phoenix.Channel
  alias PhoenixTwitterStream.TweetStreamer

  def join("tweets", %{"track" => query}, socket) do
    spawn(fn() -> TweetStreamer.start(socket, query) end)
    {:ok, socket}
  end

end
