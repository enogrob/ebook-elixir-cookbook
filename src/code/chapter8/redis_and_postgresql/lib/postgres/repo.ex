defmodule Postgres.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres
    def conf do
      # ecto://<USER>:<PASSWORD>@<HOST>/<DATABASE>
      parse_url "ecto://username@localhost/elixir_cookbook"
    end

    # define the place where to store migrations !
    def priv do
      app_dir(:redis_and_postgresql, "priv/repo")
    end

end
