defmodule MyModule do
  @behaviour Randomizer

  @moduledoc """
  This is a custom module to demo the implementation of behaviours.
  """

  @doc """
  The randomize callback defines the randomize function taking 2 arguments:\n
  \tlow:  an Integer with the lower boundary\n
  \thigh: an Integer with the upper boundary\n
  The function outputs an Integer. The output is comprised whithin the [low;high]
  interval. This function uses a guard to ensure it is only invoked when low
  value is smaller than high value.
  This function uses the rand_uniform function from erlang's crypto module
  (http://www.erlang.org/doc/man/crypto.html).
  """
  def randomize(low, high) when low < high do
    :crypto.rand_uniform(low, high)
  end
end
