defmodule MyModule do
  @behaviour Randomizer
  def randomize(low, high) when low < high do
    :crypto.rand_uniform(low, high)
  end
end
