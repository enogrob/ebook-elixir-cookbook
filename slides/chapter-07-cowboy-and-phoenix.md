---
marp: true
theme: default
class: invert
paginate: true
---

# Chapter 7: Cowboy and Phoenix

**Elixir Cookbook**
Paulo A. Pereira

---

## Overview

- Introduction to web development in Elixir
- Getting started with Cowboy HTTP server
- Serving static files
- Implementing WebSockets
- Building with Phoenix framework
- Phoenix routing and controllers
- Phoenix views and templates
- Phoenix Channels and PubSub
- SSL/TLS configuration

---

## Cowboy: Small, Fast HTTP Server

Cowboy is a lightweight, modular HTTP server for Erlang/Elixir:

**Features:**
- HTTP/1.1 and HTTP/2 support
- WebSocket support
- Small footprint
- High performance
- Modular architecture

**Add to dependencies:**
```elixir
defp deps do
  [
    {:cowboy, "~> 2.10"},
    {:plug_cowboy, "~> 2.6"}
  ]
end
```

---

## Starting a Cowboy Server

Basic Cowboy server setup:

```elixir
defmodule MyCowboyApp do
  def start do
    dispatch = :cowboy_router.compile([
      {:_, [
        {"/", MyHandler, []},
        {"/api/[...]", ApiHandler, []}
      ]}
    ])
    
    {:ok, _} = :cowboy.start_clear(
      :my_http_listener,
      [{:port, 8080}],
      %{env: %{dispatch: dispatch}}
    )
  end
end
```

---

## Cowboy Handler

Implementing a basic HTTP handler:

```elixir
defmodule MyHandler do
  def init(req, state) do
    req = :cowboy_req.reply(
      200,
      %{"content-type" => "text/plain"},
      "Hello, Cowboy!",
      req
    )
    {:ok, req, state}
  end
end

defmodule ApiHandler do
  def init(req, state) do
    method = :cowboy_req.method(req)
    handle_request(method, req, state)
  end
  
  defp handle_request("GET", req, state) do
    json = Jason.encode!(%{message: "Hello from API"})
    req = :cowboy_req.reply(200, 
      %{"content-type" => "application/json"}, json, req)
    {:ok, req, state}
  end
end
```

---

## Serving Static Files

Serve static assets with Cowboy:

```elixir
defmodule StaticServer do
  def start do
    dispatch = :cowboy_router.compile([
      {:_, [
        {"/static/[...]", :cowboy_static, 
          {:dir, "priv/static"}},
        {"/", :cowboy_static, 
          {:file, "priv/static/index.html"}}
      ]}
    ])
    
    {:ok, _} = :cowboy.start_clear(
      :static_server,
      [{:port, 8080}],
      %{env: %{dispatch: dispatch}}
    )
  end
end
```

---

## WebSockets with Cowboy

Implementing WebSocket handlers:

```elixir
defmodule WebSocketHandler do
  @behaviour :cowboy_websocket
  
  def init(req, state) do
    {:cowboy_websocket, req, state}
  end
  
  def websocket_init(state) do
    {:ok, state}
  end
  
  def websocket_handle({:text, msg}, state) do
    {:reply, {:text, "Echo: #{msg}"}, state}
  end
  
  def websocket_info(info, state) do
    {:reply, {:text, "Info: #{inspect(info)}"}, state}
  end
  
  def terminate(_reason, _req, _state) do
    :ok
  end
end
```

---

## Phoenix Framework

Phoenix is a productive web framework for Elixir:

**Features:**
- MVC architecture
- Real-time capabilities
- Built on top of Plug and Cowboy
- LiveView for interactive UIs without JavaScript
- Channel support for WebSockets
- High performance

**Installation:**
```bash
$ mix archive.install hex phx_new
$ mix phx.new my_app
$ cd my_app
$ mix phx.server
```

---

## Phoenix Project Structure

Understanding the Phoenix layout:

```
my_app/
├── config/           # Configuration files
├── lib/
│   ├── my_app/       # Business logic
│   │   └── application.ex
│   └── my_app_web/   # Web-related code
│       ├── controllers/
│       ├── views/
│       ├── templates/
│       ├── channels/
│       ├── router.ex
│       └── endpoint.ex
├── priv/             # Static assets, migrations
├── test/
└── mix.exs
```

---

## Phoenix Routing

Define URL routes in `router.ex`:

```elixir
defmodule MyAppWeb.Router do
  use MyAppWeb, :router
  
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end
  
  pipeline :api do
    plug :accepts, ["json"]
  end
  
  scope "/", MyAppWeb do
    pipe_through :browser
    
    get "/", PageController, :index
    get "/users/:id", UserController, :show
    resources "/posts", PostController
  end
end
```

---

## Phoenix Controllers

Handle HTTP requests:

```elixir
defmodule MyAppWeb.UserController do
  use MyAppWeb, :controller
  
  def index(conn, _params) do
    users = MyApp.Accounts.list_users()
    render(conn, "index.html", users: users)
  end
  
  def show(conn, %{"id" => id}) do
    user = MyApp.Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end
  
  def create(conn, %{"user" => user_params}) do
    case MyApp.Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully")
        |> redirect(to: Routes.user_path(conn, :show, user))
      
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
```

---

## Phoenix Views and Templates

Separate presentation logic:

```elixir
# lib/my_app_web/views/user_view.ex
defmodule MyAppWeb.UserView do
  use MyAppWeb, :view
  
  def full_name(user) do
    "#{user.first_name} #{user.last_name}"
  end
  
  def format_date(date) do
    Calendar.strftime(date, "%B %d, %Y")
  end
end

# lib/my_app_web/templates/user/show.html.eex
<h1><%= full_name(@user) %></h1>
<p>Email: <%= @user.email %></p>
<p>Joined: <%= format_date(@user.inserted_at) %></p>
```

---

## Phoenix API Endpoints

Building JSON APIs:

```elixir
defmodule MyAppWeb.ApiController do
  use MyAppWeb, :controller
  
  def index(conn, _params) do
    users = MyApp.Accounts.list_users()
    render(conn, "index.json", users: users)
  end
  
  def show(conn, %{"id" => id}) do
    user = MyApp.Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end
end

# View for JSON rendering
defmodule MyAppWeb.ApiView do
  use MyAppWeb, :view
  
  def render("index.json", %{users: users}) do
    %{data: Enum.map(users, &user_json/1)}
  end
  
  def render("show.json", %{user: user}) do
    %{data: user_json(user)}
  end
  
  defp user_json(user) do
    %{id: user.id, name: user.name, email: user.email}
  end
end
```

---

## Phoenix Channels

Real-time bidirectional communication:

```elixir
defmodule MyAppWeb.RoomChannel do
  use MyAppWeb, :channel
  
  def join("room:lobby", _payload, socket) do
    {:ok, socket}
  end
  
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
  
  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end
  
  def handle_out("new_msg", payload, socket) do
    push(socket, "new_msg", payload)
    {:noreply, socket}
  end
end
```

---

## Phoenix PubSub

Publish-subscribe messaging:

```elixir
defmodule MyApp.Notifier do
  alias Phoenix.PubSub
  
  def notify_user(user_id, message) do
    PubSub.broadcast(
      MyApp.PubSub,
      "user:#{user_id}",
      {:notification, message}
    )
  end
  
  def subscribe_to_user(user_id) do
    PubSub.subscribe(MyApp.PubSub, "user:#{user_id}")
  end
end

# In your GenServer or LiveView
def handle_info({:notification, message}, socket) do
  # Handle the notification
  {:noreply, push_event(socket, "notification", %{msg: message})}
end
```

---

## Phoenix LiveView

Interactive UIs without JavaScript:

```elixir
defmodule MyAppWeb.CounterLive do
  use MyAppWeb, :live_view
  
  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end
  
  def render(assigns) do
    ~H"""
    <div>
      <h1>Count: <%= @count %></h1>
      <button phx-click="increment">+</button>
      <button phx-click="decrement">-</button>
    </div>
    """
  end
  
  def handle_event("increment", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
  
  def handle_event("decrement", _params, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end
end
```

---

## SSL/TLS Configuration

Secure your Phoenix application:

```elixir
# config/prod.exs
config :my_app, MyAppWeb.Endpoint,
  https: [
    port: 443,
    cipher_suite: :strong,
    keyfile: System.get_env("SSL_KEY_PATH"),
    certfile: System.get_env("SSL_CERT_PATH"),
    transport_options: [socket_opts: [:inet6]]
  ]

# Force SSL in router
defmodule MyAppWeb.Router do
  use MyAppWeb, :router
  
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :force_ssl, rewrite_on: [:x_forwarded_proto]
  end
end
```

---

## Phoenix Plugs

Composable modules for request processing:

```elixir
defmodule MyAppWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller
  
  def init(opts), do: opts
  
  def call(conn, _opts) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> put_flash(:error, "You must be logged in")
        |> redirect(to: "/login")
        |> halt()
      
      _user_id ->
        conn
    end
  end
end

# Use in router
pipeline :authenticated do
  plug MyAppWeb.Plugs.RequireAuth
end
```

---

## Testing Phoenix Controllers

Write tests for your controllers:

```elixir
defmodule MyAppWeb.UserControllerTest do
  use MyAppWeb.ConnCase
  
  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(conn, 200) =~ "Users"
    end
  end
  
  describe "create" do
    test "creates user with valid data", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), 
        user: %{name: "Alice", email: "alice@example.com"})
      
      assert redirected_to(conn) == Routes.user_path(conn, :show, user.id)
    end
  end
end
```

---

## Testing Phoenix Channels

Test real-time features:

```elixir
defmodule MyAppWeb.RoomChannelTest do
  use MyAppWeb.ChannelCase
  
  setup do
    {:ok, _, socket} = 
      MyAppWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(MyAppWeb.RoomChannel, "room:lobby")
    
    %{socket: socket}
  end
  
  test "broadcasts new messages", %{socket: socket} do
    push(socket, "new_msg", %{"body" => "Hello"})
    assert_broadcast("new_msg", %{body: "Hello"})
  end
end
```

---

## Performance Tips

Optimize your Phoenix applications:

- **Use ETS for caching**: Fast in-memory storage
- **Leverage connection pooling**: For database connections
- **Enable gzip compression**: Reduce payload size
- **Use CDN for static assets**: Offload asset serving
- **Implement rate limiting**: Protect against abuse
- **Profile with telemetry**: Monitor performance
- **Use LiveView for interactive UIs**: Reduce JavaScript
- **Cache expensive operations**: Use Agent or ETS
- **Optimize database queries**: Use Ecto preloads

---

## Key Takeaways

- Cowboy provides a lightweight HTTP server foundation
- Phoenix builds on Cowboy with a full-featured framework
- Routes map URLs to controller actions
- Controllers handle requests, views render responses
- Channels enable real-time WebSocket communication
- PubSub facilitates message broadcasting
- LiveView enables interactive UIs without JavaScript
- Plugs provide composable request processing
- SSL/TLS configuration ensures secure communication
- Testing tools ensure application reliability

---

## Best Practices

- Keep controllers thin, business logic in contexts
- Use changesets for data validation
- Leverage Phoenix generators for scaffolding
- Implement proper error handling
- Use Channels for real-time features
- Secure endpoints with authentication plugs
- Write comprehensive tests
- Configure SSL in production
- Monitor performance with telemetry
- Follow Phoenix conventions
