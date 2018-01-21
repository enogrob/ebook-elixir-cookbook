defmodule Todo.AccessCounter do

  def start_link do
    counter = 0
    sub = spawn_link(Todo.AccessCounter, :count, [counter])
    Phoenix.PubSub.subscribe(sub, "counter_channel")
    {:ok, sub}
  end

  def count(counter) do
    receive do
      { :action, params } ->
        counter = counter + 1
        IO.puts "Action #{params[:action]} in controller #{params[:controller]} called #{counter} times!"
      _ ->
    end
    count(counter)
  end

end
