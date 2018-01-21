defmodule Todo.MyController do
  use Phoenix.Controller

  plug :action

  def plaintext(conn, _params) do
    text conn, "Plain text rendered from Phoenix controller!"
  end

  def send_html(conn, _params) do
     generated_html = """
      <html>
        <head>
          <title>Generated HTML</title>
        </head>
        <body>
          <h2>Creating Controllers</h2>
          <p>It is possible to render html from a Phoenix controller!</p>
        </body>
      </html>
    """
    html conn, generated_html
  end

end
