---
marp: true
theme: default
class: invert
paginate: true
---

# Chapter 8: Interactions

**Elixir Cookbook**
Paulo A. Pereira

---

## Overview

- Interacting with the operating system
- Working with external programs
- Database integration (PostgreSQL)
- Working with Redis
- Parsing external data sources
- Building a Twitter feed parser
- HTTP client operations
- File system operations
- Port communication

---

## Running OS Commands

Execute system commands from Elixir:

```elixir
# Using System.cmd/3
iex> System.cmd("echo", ["Hello, World!"])
{"Hello, World!\n", 0}

iex> {output, exit_code} = System.cmd("ls", ["-la"])
iex> IO.puts(output)

# Using Port for streaming output
iex> port = Port.open({:spawn, "ping -c 5 google.com"}, [:binary])
iex> receive do
...>   {^port, {:data, data}} -> IO.puts(data)
...> end

# Get environment variables
iex> System.get_env("PATH")
"/usr/local/bin:/usr/bin:/bin"
```

---

## Port Communication

Lower-level OS interaction:

```elixir
defmodule OSCommand do
  def run(command) do
    port = Port.open({:spawn, command}, [:binary, :exit_status])
    handle_port(port, "")
  end
  
  defp handle_port(port, acc) do
    receive do
      {^port, {:data, data}} ->
        handle_port(port, acc <> data)
      
      {^port, {:exit_status, 0}} ->
        {:ok, acc}
      
      {^port, {:exit_status, status}} ->
        {:error, status, acc}
    after
      5000 -> {:error, :timeout}
    end
  end
end
```

---

## Working with PostgreSQL

Using Ecto for database operations:

```elixir
# mix.exs dependencies
defp deps do
  [
    {:ecto_sql, "~> 3.10"},
    {:postgrex, "~> 0.17"}
  ]
end

# Define a repo
defmodule MyApp.Repo do
  use Ecto.Repo,
    otp_app: :my_app,
    adapter: Ecto.Adapters.Postgres
end

# Configure in config/config.exs
config :my_app, MyApp.Repo,
  database: "my_app_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
```

---

## Ecto Schemas and Queries

Define schemas and query the database:

```elixir
defmodule MyApp.User do
  use Ecto.Schema
  import Ecto.Changeset
  
  schema "users" do
    field :name, :string
    field :email, :string
    field :age, :integer
    
    timestamps()
  end
  
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :age])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
```

---

## Ecto CRUD Operations

Create, read, update, delete:

```elixir
alias MyApp.{Repo, User}
import Ecto.Query

# Create
changeset = User.changeset(%User{}, %{name: "Alice", email: "alice@example.com"})
{:ok, user} = Repo.insert(changeset)

# Read
user = Repo.get(User, 1)
user = Repo.get_by(User, email: "alice@example.com")
users = Repo.all(User)

# Query
query = from u in User, where: u.age > 18, select: u
adults = Repo.all(query)

# Update
changeset = User.changeset(user, %{name: "Alice Smith"})
{:ok, updated_user} = Repo.update(changeset)

# Delete
{:ok, deleted_user} = Repo.delete(user)
```

---

## Working with Redis

Using Redix for Redis operations:

```elixir
# Add dependency
defp deps do
  [
    {:redix, "~> 1.3"}
  ]
end

# Start connection
{:ok, conn} = Redix.start_link(host: "localhost", port: 6379)

# Basic operations
{:ok, "OK"} = Redix.command(conn, ["SET", "key", "value"])
{:ok, "value"} = Redix.command(conn, ["GET", "key"])

# Lists
Redix.command(conn, ["LPUSH", "mylist", "item1"])
Redix.command(conn, ["LPUSH", "mylist", "item2"])
{:ok, items} = Redix.command(conn, ["LRANGE", "mylist", "0", "-1"])

# Hashes
Redix.command(conn, ["HSET", "user:1", "name", "Alice"])
{:ok, name} = Redix.command(conn, ["HGET", "user:1", "name"])
```

---

## Redis with Connection Pool

Production-ready Redis setup:

```elixir
defmodule MyApp.Redis do
  def child_spec(_opts) do
    children = [
      {Redix, host: "localhost", port: 6379, name: :redix}
    ]
    
    %{
      id: __MODULE__,
      start: {Supervisor, :start_link, [children, [strategy: :one_for_one]]},
      type: :supervisor
    }
  end
  
  def set(key, value) do
    Redix.command(:redix, ["SET", key, value])
  end
  
  def get(key) do
    Redix.command(:redix, ["GET", key])
  end
  
  def expire(key, seconds) do
    Redix.command(:redix, ["EXPIRE", key, seconds])
  end
end
```

---

## HTTP Client with HTTPoison

Making HTTP requests:

```elixir
# Add dependency
defp deps do
  [
    {:httpoison, "~> 2.0"}
  ]
end

# GET request
case HTTPoison.get("https://api.example.com/users") do
  {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
    Jason.decode!(body)
  
  {:ok, %HTTPoison.Response{status_code: 404}} ->
    {:error, :not_found}
  
  {:error, %HTTPoison.Error{reason: reason}} ->
    {:error, reason}
end

# POST request
body = Jason.encode!(%{name: "Alice", email: "alice@example.com"})
headers = [{"Content-Type", "application/json"}]
HTTPoison.post("https://api.example.com/users", body, headers)
```

---

## Building a Twitter Feed Parser

Practical example of API integration:

```elixir
defmodule MyApp.TwitterClient do
  @base_url "https://api.twitter.com/2"
  
  def user_timeline(user_id, token) do
    url = "#{@base_url}/users/#{user_id}/tweets"
    headers = [
      {"Authorization", "Bearer #{token}"},
      {"Content-Type", "application/json"}
    ]
    
    case HTTPoison.get(url, headers) do
      {:ok, %{status_code: 200, body: body}} ->
        parse_tweets(body)
      
      {:ok, %{status_code: status}} ->
        {:error, "HTTP #{status}"}
      
      {:error, error} ->
        {:error, error.reason}
    end
  end
  
  defp parse_tweets(body) do
    body
    |> Jason.decode!()
    |> Map.get("data", [])
    |> Enum.map(&extract_tweet/1)
  end
  
  defp extract_tweet(tweet) do
    %{
      id: tweet["id"],
      text: tweet["text"],
      created_at: tweet["created_at"]
    }
  end
end
```

---

## Streaming Twitter Data

Real-time tweet processing:

```elixir
defmodule MyApp.TwitterStream do
  use GenServer
  
  def start_link(token) do
    GenServer.start_link(__MODULE__, token, name: __MODULE__)
  end
  
  def init(token) do
    url = "https://api.twitter.com/2/tweets/sample/stream"
    headers = [{"Authorization", "Bearer #{token}"}]
    
    HTTPoison.get!(url, headers, stream_to: self(), async: :once)
    {:ok, %{buffer: ""}}
  end
  
  def handle_info(%HTTPoison.AsyncChunk{chunk: chunk}, state) do
    process_chunk(chunk, state)
    HTTPoison.stream_next(%HTTPoison.AsyncResponse{id: self()})
    {:noreply, state}
  end
  
  defp process_chunk(chunk, state) do
    # Process streaming tweets
    chunk
    |> String.split("\r\n")
    |> Enum.each(&handle_tweet/1)
  end
end
```

---

## File System Operations

Working with files and directories:

```elixir
# Reading files
{:ok, content} = File.read("path/to/file.txt")
content = File.read!("path/to/file.txt")  # Raises on error

# Writing files
:ok = File.write("path/to/file.txt", "content")
File.write!("path/to/file.txt", "content")

# Streaming large files
File.stream!("large_file.txt")
|> Stream.map(&String.trim/1)
|> Stream.filter(&(&1 != ""))
|> Enum.to_list()

# Directory operations
{:ok, files} = File.ls("path/to/dir")
:ok = File.mkdir_p("path/to/nested/dir")
:ok = File.rm_rf("path/to/dir")

# File info
{:ok, stat} = File.stat("file.txt")
stat.size  # File size in bytes
```

---

## Path Operations

Working with file paths:

```elixir
# Join paths
path = Path.join(["home", "user", "file.txt"])
# "home/user/file.txt"

# Expand paths
Path.expand("~/file.txt")
# "/home/user/file.txt"

# Extract components
Path.basename("path/to/file.txt")  # "file.txt"
Path.dirname("path/to/file.txt")   # "path/to"
Path.extname("file.txt")           # ".txt"
Path.rootname("file.txt")          # "file"

# Check paths
Path.absname("relative/path")
# "/current/working/dir/relative/path"
```

---

## Parsing CSV Data

Processing CSV files:

```elixir
defmodule CSVParser do
  def parse_file(path) do
    path
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ","))
    |> Enum.to_list()
  end
  
  def parse_with_headers(path) do
    [headers | rows] = parse_file(path)
    
    Enum.map(rows, fn row ->
      headers
      |> Enum.zip(row)
      |> Map.new()
    end)
  end
end

# Usage
iex> CSVParser.parse_with_headers("users.csv")
[
  %{"name" => "Alice", "email" => "alice@example.com"},
  %{"name" => "Bob", "email" => "bob@example.com"}
]
```

---

## Parsing JSON Data

Working with JSON:

```elixir
# Add dependency
defp deps do
  [
    {:jason, "~> 1.4"}
  ]
end

# Encoding
data = %{name: "Alice", age: 30}
{:ok, json} = Jason.encode(data)
# "{\"name\":\"Alice\",\"age\":30}"

json = Jason.encode!(data)  # Raises on error

# Decoding
{:ok, decoded} = Jason.decode(json)
# %{"name" => "Alice", "age" => 30}

decoded = Jason.decode!(json)

# With atom keys
Jason.decode!(json, keys: :atoms)
# %{name: "Alice", age: 30}
```

---

## Parsing XML Data

Working with XML:

```elixir
# Add dependency
defp deps do
  [
    {:sweet_xml, "~> 0.7"}
  ]
end

import SweetXml

xml = """
<users>
  <user id="1">
    <name>Alice</name>
    <email>alice@example.com</email>
  </user>
  <user id="2">
    <name>Bob</name>
    <email>bob@example.com</email>
  </user>
</users>
"""

# Extract data
users = xml
|> xpath(~x"//user"l,
  id: ~x"./@id"s,
  name: ~x"./name/text()"s,
  email: ~x"./email/text()"s
)
```

---

## Environment Configuration

Managing configuration:

```elixir
# config/config.exs
import Config

config :my_app,
  api_key: System.get_env("API_KEY"),
  database_url: System.get_env("DATABASE_URL")

config :my_app, MyApp.Repo,
  url: System.get_env("DATABASE_URL")

# Runtime configuration (config/runtime.exs)
import Config

if config_env() == :prod do
  config :my_app,
    api_key: System.fetch_env!("API_KEY"),
    secret_key: System.fetch_env!("SECRET_KEY")
end

# Access configuration
Application.get_env(:my_app, :api_key)
Application.fetch_env!(:my_app, :api_key)
```

---

## Working with Timezones

Handling dates and times:

```elixir
# Add dependency
defp deps do
  [
    {:timex, "~> 3.7"}
  ]
end

# Current time
now = Timex.now()
utc_now = Timex.now("UTC")

# Parse dates
{:ok, date} = Timex.parse("2024-01-15", "{YYYY}-{0M}-{0D}")

# Format dates
Timex.format!(now, "{YYYY}-{0M}-{0D} {h24}:{m}:{s}")

# Convert timezones
pst_time = Timex.Timezone.convert(now, "America/Los_Angeles")

# Date arithmetic
tomorrow = Timex.shift(now, days: 1)
next_week = Timex.shift(now, weeks: 1)
```

---

## Logging

Application logging:

```elixir
require Logger

# Log levels
Logger.debug("Debug message")
Logger.info("Info message")
Logger.warning("Warning message")
Logger.error("Error message")

# With metadata
Logger.info("User logged in", user_id: user.id, ip: conn.remote_ip)

# Configure in config/config.exs
config :logger,
  level: :info,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Custom backend
config :logger,
  backends: [:console, {LoggerFileBackend, :error_log}]
```

---

## Telemetry and Monitoring

Instrument your application:

```elixir
# Execute telemetry events
:telemetry.execute(
  [:my_app, :api, :request],
  %{duration: 150},
  %{endpoint: "/users", method: "GET"}
)

# Attach handlers
:telemetry.attach(
  "my-app-handler",
  [:my_app, :api, :request],
  &handle_event/4,
  nil
)

def handle_event(_event, measurements, metadata, _config) do
  Logger.info("API request",
    endpoint: metadata.endpoint,
    duration: measurements.duration
  )
end
```

---

## Error Handling Best Practices

Robust error handling:

```elixir
defmodule MyApp.ErrorHandler do
  def safe_api_call(url) do
    case HTTPoison.get(url) do
      {:ok, %{status_code: 200, body: body}} ->
        parse_response(body)
      
      {:ok, %{status_code: status}} when status >= 400 ->
        {:error, {:http_error, status}}
      
      {:error, %{reason: reason}} ->
        Logger.error("HTTP request failed: #{inspect(reason)}")
        {:error, :network_error}
    end
  rescue
    error ->
      Logger.error("Unexpected error: #{inspect(error)}")
      {:error, :unknown}
  end
  
  defp parse_response(body) do
    case Jason.decode(body) do
      {:ok, data} -> {:ok, data}
      {:error, _} -> {:error, :invalid_json}
    end
  end
end
```

---

## Key Takeaways

- System.cmd and Port enable OS interaction
- Ecto provides powerful database integration
- Redix simplifies Redis operations
- HTTPoison handles HTTP client operations
- File and Path modules manage file system operations
- JSON, CSV, and XML parsing are straightforward
- Configuration can be managed at runtime
- Telemetry enables application monitoring
- Proper error handling is essential
- External integrations benefit from GenServer patterns

---

## Best Practices

- Always handle errors from external systems
- Use connection pooling for databases and Redis
- Implement retry logic for network operations
- Log important interactions
- Use streaming for large data sets
- Validate external data before processing
- Configure timeouts appropriately
- Monitor external service health
- Keep credentials in environment variables
- Test external integrations with mocks
