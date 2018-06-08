defmodule Randomizer do
  use Behaviour
  defcallback randomize(low::Integer.t, high::Integer.t) :: Integer.t
end
