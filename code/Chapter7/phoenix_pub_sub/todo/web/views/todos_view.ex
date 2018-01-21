defmodule Todo.TodosView do
  use Todo.View

  def todos(conn) do
    Enum.map(conn.assigns.todos, fn(x)->x[:task] end)
  end
end
