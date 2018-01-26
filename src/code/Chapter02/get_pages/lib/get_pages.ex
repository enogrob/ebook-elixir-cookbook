defmodule GetPages do

  def get(element, url \\ "http://elixir-lang.org") do
    case element do
      :headers ->
        %{headers: headers} = fetch_url(url)
        headers
      :body ->
        %{body: body} = fetch_url(url)
        body
      _ ->
        IO.puts "Section unavailable or not known!"
    end
  end

  def fetch_url(url)  do
    {:ok, response} = HTTPoison.get(url)
    response
  end
end
