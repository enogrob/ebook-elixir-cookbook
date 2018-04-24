defmodule ConfigExampleTest do
  use ExUnit.Case
  doctest ConfigExample

  test "greets the world" do
    assert ConfigExample.hello() == :world
  end
end
