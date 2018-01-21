defmodule MultipleCalculations do

  def start do

    Enum.each([40000000, 30000000,20000000,10000000], fn(x) ->
      spawn(fn() ->
        start_time = time_in_miliseconds
        IO.puts "Sum of the squares of all odd numbers divisible by 13 between 1 and #{x} is #{calculate(x)}"
        end_time = time_in_miliseconds
        IO.puts "time: #{end_time - start_time} ms"
      end)
    end)

  end

  defp calculate(n) do
    1..n |> Stream.filter_map((&(rem(&1,13)==0)), (&(&1*&1))) |> Stream.filter(&(rem(&1,2)==1)) |> Enum.sum
  end

  defp time_in_miliseconds do
    {mega, sec, micro} = :os.timestamp
    (mega*1000000 + sec)*1000 + :erlang.round(micro/1000)
  end

end
