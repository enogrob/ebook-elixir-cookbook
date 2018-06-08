require Logger

defmodule WordFrequency do

  def main(args) do
    options = parse_args(args)
    Logger.info "Input file: #{options[:file]}"
    word_frequency_map = File.stream!(options[:file]) |>
                         get_word_list_stream |>
                         count_words
    Logger.info "Processing entries ..."
    write_to_file(word_frequency_map)
    Logger.info "File word_frequency.txt written !"
  end

  defp count_words(stream) do
    count_words(Enum.to_list(stream),Map.new)
  end
  defp count_words([], map), do: map
  defp count_words([word|rest], map) do
    case Map.has_key?(map, word) do
      true ->
        map = Map.update!(map, word, fn(val) -> val + 1 end)
        count_words(rest, map)
      false ->
        map = Map.put_new(map, word, 1)
        count_words(rest, map)
    end
  end

  defp write_to_file(map) do
    reduce = fn(key, acc) -> acc <> "#{key}: #{Map.get(map, key)} time(s)\n" end
    output = map |> Map.keys |> Enum.reduce(" ", reduce)
    File.write!("word_frequency.txt", output)
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(args, switches: [file: :string])
    options
  end

  defp get_word_list_stream(file_stream) do
    map_fn = fn x -> String.split(x, ~r{[^A-Za-z0-9_]}) end
    filter_fn = fn x -> String.length(x) > 0 end
    file_stream |> Stream.flat_map(map_fn) |> Stream.filter(filter_fn)
  end

end
