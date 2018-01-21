defmodule SupervisedAppTest do
  use ExUnit.Case
  doctest SupervisedApp

  test "greets the world" do
    assert SupervisedApp.hello() == :world
  end
end
