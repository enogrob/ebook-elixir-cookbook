defmodule Geolocator do

  @ip_list [ "216.58.209.227", "199.16.156.198", "213.13.146.138",
             "114.134.80.162", "134.170.188.221", "216.58.210.3"]

  def concurrent(ip_list \\ @ip_list) when is_list ip_list do
    ip_list
    |> Enum.map(fn(ip)->
      Task.async(fn -> ip |> locate end)
    end)
    |> Enum.map(&Task.await/1)
  end

  def sequential(ip_list \\ @ip_list) when is_list ip_list do
    Enum.map(ip_list, fn(x) -> locate(x) end)
  end

  def locate(ip) do
    case Geolix.lookup(ip) do
      %{country: country} ->
        location = get_in(country, [:country, :names, :en])
        IO.puts "IP: #{ip}  Country: #{location}"
      _ ->
        IO.puts "Could not determine the location of IP #{ip}"
      end
  end

end
