defmodule Todo.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Todo do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/text", MyController, :plaintext
    get "/generated", MyController, :send_html

    resources "todos", TodosController, only: [:index]

  end

  # Other scopes may use custom stacks.
  # scope "/api", Todo do
  #   pipe_through :api
  # end
end
