defmodule OsCommands do
  alias Porcelain.Result

  def list(path \\ ".") do
    %Result{out: output, status: status} = Porcelain.exec("ls", [path])
    IO.puts output
  end

  def run(command, options \\"") do
    %Result{out: output, status: status} = Porcelain.shell("#{command} #{options}")
    IO.puts output
  end
end
