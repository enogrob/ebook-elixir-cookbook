defmodule Transformator do

  @default_list [1, 2, 3, 4, 5, 6]

  def get_odd_numbers(list \\ @default_list) do
    Enum.filter(list, fn(x)-> rem(x,2) == 1 end)
  end

  def get_even_numbers(list \\ @default_list) do
    Enum.filter(list, fn(x)-> rem(x,2) == 0 end)
  end

end
