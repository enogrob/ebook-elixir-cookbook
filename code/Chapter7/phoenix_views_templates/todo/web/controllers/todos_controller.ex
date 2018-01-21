defmodule Todo.TodosController do
  use Phoenix.Controller

  plug :action
  plug :render

  def index(conn, _params) do
    todos = [%{id: 1, task: "Write the other controller actions!", created_at: "2014-12-13", status: "pending"}, %{id: 2, task: "Create Views", created_at: "2014-12-13", status: "pending"}]
    assign(conn, :todos, todos)
  end
end
