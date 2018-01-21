defmodule PatternsAndGuards do

  #guards
  def print(x) when is_list(x) do
    IO.puts "Printing a list -> #{inspect(x)}"
  end
  def print(x) when is_binary(x) do
    IO.puts "Printing a binary -> #{inspect(x)}"
  end
  def print(x) do
    IO.puts "Printing a non-list/binary -> #{inspect(x)}"
  end

  #pattern matching
  def print_each_from_list([]) do
    :ok
  end
  def print_each_from_list([h|t]) do
    print(h)
    print_each_from_list(t)
  end

end
