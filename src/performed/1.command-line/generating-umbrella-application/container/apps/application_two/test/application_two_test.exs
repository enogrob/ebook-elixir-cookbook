defmodule ApplicationTwoTest do
  use ExUnit.Case
  doctest ApplicationTwo

  test "the truth on application two" do
     IO.puts "Running Application Two tests"
     assert 2 - 1 == 1
  end
end
