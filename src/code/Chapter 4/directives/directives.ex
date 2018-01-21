defmodule Directives do
  @col  [1,2,3]
  @name "demo"

  # require directive

  # alias directive module scope
  alias String, as: S
  # import directive module scope
  import List, only: [first: 1]

  def test_module_alias do
    IO.puts "Name is #{S.capitalize(@name)}"
  end

  def test_function_alias do
    # alias directive function scope
    alias RequireMe, as: RM
    RM.foo
  end

  def test_module_import do
    IO.puts "First element of #{inspect(@col)} is #{first(@col)}"
  end

  def test_function_import do
    # import directive function scope
    import Enum, only: [count: 1]
    IO.puts "#{inspect(@col)} has #{count(@col)} elements"
  end
end
