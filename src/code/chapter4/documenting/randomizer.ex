defmodule Randomizer do
  use Behaviour
  @moduledoc """
  This module specifies the interface for a randomizer behaviour by using the defcallback macro.
  """

  defcallback randomize(low::Integer.t, high::Integer.t) :: Integer.t
end
