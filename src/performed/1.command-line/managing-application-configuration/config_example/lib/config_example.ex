defmodule ConfigExample do
  @message_one Application.get_env(:config_example, :message_one)
  @message_two Application.get_env(:config_example, :message_two)

  def show_message do
    IO.puts "Message one is: #{@message_one}"
    IO.puts "Message two is: #{@message_two}"
  end
end

ConfigExample.show_message
