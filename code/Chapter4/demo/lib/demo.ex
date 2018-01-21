defmodule Demo do

  # insert the run_me function here !
  def run_me(name \\ "Stranger") do
    IO.puts " #{__MODULE__} says \"Hi there #{name}!\""
    Demo.Greeter.greet
    Demo.One.Greeter.greet
    Demo.Two.Greeter.greet
  end

end
