---
marp: true
theme: default
class: invert
paginate: true
---

# Chapter 6: OTP - Open Telecom Platform

**Elixir Cookbook**
Paulo A. Pereira

---

## Overview

- Understanding OTP principles
- Building GenServers
- Creating supervisors
- Supervision strategies
- Building fault-tolerant systems
- Applications and releases
- Error handling patterns
- OTP design principles

---

## What is OTP?

OTP (Open Telecom Platform) is a set of libraries and design principles:

- **GenServer**: Generic server behavior
- **Supervisor**: Process supervision
- **Application**: Application structure
- **GenEvent**: Event handling (deprecated, use Registry/PubSub)
- **GenStateMachine**: State machine implementation

**Benefits:**
- Battle-tested patterns
- Built-in error handling
- Supervision trees
- Hot code reloading
- Fault tolerance

---

## GenServer: The Foundation

GenServer implements the server in a client-server relationship:

```elixir
defmodule Stack do
  use GenServer
  
  # Client API
  def start_link(default) do
    GenServer.start_link(__MODULE__, default, name: __MODULE__)
  end
  
  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end
  
  def pop do
    GenServer.call(__MODULE__, :pop)
  end
end
```

---

## GenServer: Server Callbacks

Implement the server behavior:

```elixir
defmodule Stack do
  use GenServer
  
  # Server Callbacks
  def init(stack) do
    {:ok, stack}
  end
  
  def handle_cast({:push, item}, stack) do
    {:noreply, [item | stack]}
  end
  
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end
  
  def handle_call(:pop, _from, []) do
    {:reply, nil, []}
  end
end
```

---

## GenServer: Complete Example

A key-value store with GenServer:

```elixir
defmodule KVStore do
  use GenServer
  
  # Client API
  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end
  
  def put(key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end
  
  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end
  
  # Server Callbacks
  def init(state), do: {:ok, state}
  
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end
  
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end
end
```

---

## GenServer: Call vs Cast

Understanding synchronous and asynchronous operations:

```elixir
# Call (synchronous) - waits for response
def handle_call(:get_state, _from, state) do
  {:reply, state, state}
end

# Cast (asynchronous) - fire and forget
def handle_cast({:update, value}, state) do
  {:noreply, Map.put(state, :value, value)}
end

# Info (handle any message)
def handle_info(:timeout, state) do
  IO.puts("Timeout occurred")
  {:noreply, state}
end

# Terminate (cleanup)
def terminate(reason, state) do
  IO.puts("Terminating: #{inspect(reason)}")
  :ok
end
```

---

## Supervisors: The Safety Net

Supervisors monitor and restart child processes:

```elixir
defmodule MyApp.Supervisor do
  use Supervisor
  
  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end
  
  def init(_init_arg) do
    children = [
      {Stack, [:hello]},
      {KVStore, []},
      {Worker, [arg1, arg2]}
    ]
    
    Supervisor.init(children, strategy: :one_for_one)
  end
end
```

---

## Supervision Strategies

Different strategies for different failure scenarios:

**`:one_for_one`** - Restart only failed child
```elixir
children = [Worker1, Worker2, Worker3]
Supervisor.init(children, strategy: :one_for_one)
# If Worker2 fails, only Worker2 restarts
```

**`:one_for_all`** - Restart all children if one fails
```elixir
Supervisor.init(children, strategy: :one_for_all)
# If Worker2 fails, all workers restart
```

**`:rest_for_one`** - Restart failed child and those started after it
```elixir
Supervisor.init(children, strategy: :rest_for_one)
# If Worker2 fails, Worker2 and Worker3 restart
```

---

## Supervisor Options

Fine-tune supervisor behavior:

```elixir
defmodule MyApp.Supervisor do
  use Supervisor
  
  def init(_) do
    children = [
      {Worker, []}
    ]
    
    opts = [
      strategy: :one_for_one,
      max_restarts: 3,        # Max restarts allowed
      max_seconds: 5,         # Within this time window
      auto_shutdown: :never   # Shutdown behavior
    ]
    
    Supervisor.init(children, opts)
  end
end
```

If `max_restarts` exceeds in `max_seconds`, supervisor terminates.

---

## Child Specifications

Customize how children are supervised:

```elixir
defmodule Worker do
  use GenServer
  
  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      restart: :permanent,  # :permanent | :temporary | :transient
      shutdown: 5000,       # Milliseconds or :brutal_kill
      type: :worker         # :worker | :supervisor
    }
  end
  
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end
end
```

---

## Dynamic Supervisors

Start children dynamically at runtime:

```elixir
defmodule MyApp.DynamicSupervisor do
  use DynamicSupervisor
  
  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end
  
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
  
  def start_worker(arg) do
    child_spec = {Worker, arg}
    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end
end

# Usage
iex> MyApp.DynamicSupervisor.start_worker(:arg1)
{:ok, #PID<...>}
```

---

## Applications

Applications are the top-level OTP structure:

```elixir
defmodule MyApp.Application do
  use Application
  
  def start(_type, _args) do
    children = [
      {MyApp.Repo, []},
      {MyApp.Supervisor, []},
      {MyApp.Endpoint, []}
    ]
    
    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```

Configure in `mix.exs`:
```elixir
def application do
  [
    mod: {MyApp.Application, []},
    extra_applications: [:logger, :runtime_tools]
  ]
end
```

---

## Error Handling: Let It Crash

The OTP philosophy for error handling:

```elixir
defmodule RiskyWorker do
  use GenServer
  
  def init(_) do
    # Don't use try/catch everywhere
    # Let supervisor handle failures
    {:ok, %{}}
  end
  
  def handle_call(:risky_operation, _from, state) do
    # This might fail - that's OK!
    result = do_risky_thing()
    {:reply, result, state}
  end
  
  defp do_risky_thing do
    # If this crashes, supervisor restarts the process
    File.read!("/nonexistent/file")
  end
end
```

**Philosophy**: Write code for the happy path, let supervisors handle failures.

---

## Selective Error Handling

Handle specific errors, let others crash:

```elixir
defmodule SmartWorker do
  use GenServer
  
  def handle_call(:operation, _from, state) do
    result = 
      case do_operation() do
        {:ok, value} -> value
        {:error, :retryable} -> retry_operation()
        {:error, :fatal} -> 
          # Let it crash - supervisor will restart
          raise "Fatal error"
      end
    
    {:reply, result, state}
  end
  
  defp retry_operation do
    # Implement retry logic for recoverable errors
    :timer.sleep(1000)
    do_operation()
  end
end
```

---

## Minimal GenServer Example

The simplest production-ready server:

```elixir
defmodule MinimalServer do
  use GenServer
  
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end
  
  @impl true
  def init(state) do
    {:ok, state}
  end
  
  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end
  
  @impl true
  def handle_cast({:put, value}, _state) do
    {:noreply, value}
  end
end
```

---

## Supervision Tree Example

Building a complete supervision tree:

```elixir
defmodule MyApp.Supervisor do
  use Supervisor
  
  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end
  
  def init(_opts) do
    children = [
      # Database connection pool
      {MyApp.Repo, []},
      
      # Cache server
      {MyApp.Cache, []},
      
      # Worker supervisor
      {MyApp.WorkerSupervisor, []},
      
      # Web endpoint
      {MyApp.Endpoint, []}
    ]
    
    Supervisor.init(children, strategy: :one_for_one)
  end
end
```

---

## Named Processes

Register processes for easy access:

```elixir
# Local registration
GenServer.start_link(Worker, [], name: :my_worker)
GenServer.call(:my_worker, :get)

# Via tuple (custom registry)
GenServer.start_link(Worker, [], name: {:via, Registry, {MyApp.Registry, "worker1"}})

# Global registration (across nodes)
GenServer.start_link(Worker, [], name: {:global, :my_worker})

# Module name
defmodule Worker do
  use GenServer
  
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end
end

GenServer.call(Worker, :get)
```

---

## Process Registry

Use Registry for dynamic process naming:

```elixir
# Start registry in supervision tree
children = [
  {Registry, keys: :unique, name: MyApp.Registry}
]

# Register process
{:ok, pid} = GenServer.start_link(Worker, [], 
  name: {:via, Registry, {MyApp.Registry, "worker1"}})

# Lookup process
[{pid, _}] = Registry.lookup(MyApp.Registry, "worker1")

# Call via registry
GenServer.call({:via, Registry, {MyApp.Registry, "worker1"}}, :get)
```

---

## Releases

Package applications for deployment:

```bash
# Configure in mix.exs
def project do
  [
    app: :my_app,
    version: "0.1.0",
    releases: [
      my_app: [
        include_executables_for: [:unix],
        applications: [runtime_tools: :permanent]
      ]
    ]
  ]
end

# Build release
$ mix release

# Run release
$ _build/prod/rel/my_app/bin/my_app start
```

---

## Key Takeaways

- OTP provides battle-tested patterns for building robust systems
- GenServer implements client-server pattern
- Supervisors monitor and restart failed processes
- Supervision strategies determine failure handling
- "Let it crash" philosophy simplifies error handling
- Applications structure top-level supervision trees
- Dynamic supervisors allow runtime child management
- Registry enables dynamic process naming
- Releases package apps for production deployment

---

## Best Practices

- Use GenServer for stateful processes
- Design supervision trees carefully
- Choose appropriate supervision strategies
- Let processes crash for unexpected errors
- Handle expected errors explicitly
- Use named processes sparingly
- Leverage Registry for dynamic naming
- Test supervision behavior
- Keep process state minimal
- Design for fault tolerance from the start
