defmodule WordFrequency.Mixfile do
  use Mix.Project

  def project do
    [app: :word_frequency,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     escript: [main_module: WordFrequency],
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end
end
