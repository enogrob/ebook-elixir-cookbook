defmodule GeolocationWithTasks.Mixfile do
  use Mix.Project

  def project do
    [app: :geolocation_with_tasks,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger, :geolix],
     mod: {GeolocationWithTasks, []}]
  end

  defp deps do
    [
      { :geolix, github: "mneudert/geolix" }
    ]
  end
end
