defmodule ReleaseMe.Mixfile do
  use Mix.Project

  def project do
    [app: :release_me,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [applications: [:logger],
     mod: {ReleaseMe, []}]
  end

  defp deps do
    [{:exrm, "~> 0.14.13"}]
  end
end
