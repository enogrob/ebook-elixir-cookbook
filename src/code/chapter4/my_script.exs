%{:date => d, :version => v} = System.build_info
IO.puts """
Command line arguments passed: #{inspect(System.argv)}
Elixir version: #{v} (#{d})
"""
