defmodule Constants do
  @name "Bill"
  @age 22

  def function_one do
    IO.puts("#{@name} is #{@age} years old.")
  end

  @name "joe"
  def function_two do
    IO.puts("#{String.upcase(@name)} is #{@age+1} years old.")
  end
end
