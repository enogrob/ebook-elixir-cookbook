defmodule ErrorHandling do

  def safe_division(a, b) do
    try do
      div(a,b)
    rescue
      _error -> _error
    end
  end

  def throw_on_zero(list) do
    try do
      Enum.each list, fn(_number)-> if _number == 0, do: throw(_number) end
      "Good! No zeros on the list!"
    catch
      _number -> "Oops! There was a #{_number} on the list!"
    end
  end

  def shortest_living_process do
    IO.puts "Spawning process..."
    spawn_link fn ->
                IO.puts "Process started!"
                exit(1)
              end
  end

end
