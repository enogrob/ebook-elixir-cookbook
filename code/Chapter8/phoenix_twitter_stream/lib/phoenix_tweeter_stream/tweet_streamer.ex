defmodule PhoenixTwitterStream.TweetStreamer do

  def start(socket, query) do
    stream = ExTwitter.stream_filter(track: query)
    for tweet <- stream do
      Phoenix.Channel.reply(socket, "tweet:stream", tweet)
    end
  end

end
