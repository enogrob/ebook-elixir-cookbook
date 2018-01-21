require Logger

defmodule PipeTransformation do
  def main(args) do
    options = parse_args(args)
    Logger.info "PipeTransformation"
    Logger.info "Input file: #{options[:input]} Output file: #{options[:output]}"
    Logger.info "Transformation started ..."
    perform_transformation(options)
    Logger.info "Transformation finished ..."
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(
                        args,
                        switches: [input: :string, output: :string]
                      )
    options
  end

  defp perform_transformation(options) do
    File.stream!(options[:input]) |>
    Stream.map(&String.upcase(&1)) |>
    Stream.map(&String.replace(&1, ~r{[AEIOU]}, "@")) |>
    Stream.into(File.stream!(options[:output])) |>
    Stream.run
  end
end
