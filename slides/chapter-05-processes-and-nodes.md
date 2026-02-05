---
marp: true
theme: default
class: invert
paginate: true
---

# Chapter 5: Processes and Nodes

**Elixir Cookbook**
Paulo A. Pereira

---

## Overview

- Understanding Elixir processes
- Spawning and managing processes
- Message passing between processes
- Process monitoring and linking
- Working with distributed nodes
- Connecting nodes and remote execution
- Building concurrent applications
- ETS (Erlang Term Storage)

---

## Introduction to Processes

Processes are the building blocks of concurrency in Elixir:

- **Lightweight**: Thousands to millions can run concurrently
- **Isolated**: No shared memory, independent state
- **Message-based**: Communicate via asynchronous messages
- **Fast**: Creation and context switching are efficient

```elixir
# Process identifiers (PIDs)
iex> self()
#PID<0.105.0>

iex> is_pid(self())
true
```

---

## Spawning Processes

Create new processes with `spawn`:

```elixir
# Spawn with anonymous function
iex> pid = spawn(fn -> 
...>   IO.puts("Hello from process #{inspect(self())}")
...> end)
Hello from process #PID<0.110.0>
#PID<0.110.0>

# Spawn with module, function, args
iex> spawn(IO, :puts, ["Hello"])
Hello
#PID<0.112.0>

# Spawn and execute code
defmodule Worker do
  def work(name) do
    IO.puts("Worker #{name} started: #{inspect(self())}")
  end
end

iex> spawn(Worker, :work, ["A"])
Worker A started: #PID<0.115.0>
```

---

## Sending Messages

Processes communicate via message passing:

```elixir
# Send a message
iex> pid = self()
iex> send(pid, {:hello, "World"})
{:hello, "World"}

# Receive messages
iex> receive do
...>   {:hello, msg} -> IO.puts("Received: #{msg}")
...> end
Received: World

# Receive with timeout
iex> receive do
...>   :never_sent -> :ok
...> after
...>   1000 -> IO.puts("Timeout!")
...> end
Timeout!
```

---

## Building a Message Handler

Practical example of message-based concurrency:

```elixir
defmodule MessageHandler do
  def start do
    spawn(__MODULE__, :loop, [])
  end
  
  def loop do
    receive do
      {:echo, msg, from} ->
        send(from, {:response, msg})
        loop()
      
      :stop ->
        IO.puts("Stopping handler")
      
      _ ->
        IO.puts("Unknown message")
        loop()
    end
  end
end

iex> pid = MessageHandler.start()
iex> send(pid, {:echo, "Hello", self()})
iex> flush()
{:response, "Hello"}
```

---

## Process Links and Monitoring

Processes can be linked or monitored:

```elixir
# Linking processes (bidirectional)
iex> spawn_link(fn -> raise "Error!" end)
** (EXIT from #PID<...>) an exception was raised

# Monitoring processes (unidirectional)
iex> pid = spawn(fn -> :timer.sleep(1000) end)
iex> ref = Process.monitor(pid)
iex> flush()
{:DOWN, #Reference<...>, :process, #PID<...>, :normal}

# Trapping exits
Process.flag(:trap_exit, true)
iex> spawn_link(fn -> exit(:reason) end)
iex> receive do
...>   {:EXIT, pid, reason} -> IO.puts("Process died: #{reason}")
...> end
```

---

## Process State with Recursion

Maintaining state through recursive loops:

```elixir
defmodule Counter do
  def start(initial \\ 0) do
    spawn(__MODULE__, :loop, [initial])
  end
  
  def loop(count) do
    receive do
      :increment ->
        loop(count + 1)
      
      :decrement ->
        loop(count - 1)
      
      {:get, from} ->
        send(from, {:count, count})
        loop(count)
      
      :stop ->
        :ok
    end
  end
end

iex> pid = Counter.start(0)
iex> send(pid, :increment)
iex> send(pid, {:get, self()})
iex> flush()
{:count, 1}
```

---

## Agent: Simplified State Management

Agent provides a simple abstraction for state:

```elixir
# Start an agent
iex> {:ok, agent} = Agent.start_link(fn -> %{count: 0} end)

# Get state
iex> Agent.get(agent, fn state -> state.count end)
0

# Update state
iex> Agent.update(agent, fn state -> 
...>   %{state | count: state.count + 1}
...> end)

iex> Agent.get(agent, fn state -> state.count end)
1

# Stop agent
iex> Agent.stop(agent)
:ok
```

---

## Task: Async Computation

Task simplifies spawning processes for computation:

```elixir
# Simple async task
iex> task = Task.async(fn -> 
...>   :timer.sleep(1000)
...>   42
...> end)

iex> Task.await(task)
42

# Multiple parallel tasks
tasks = Enum.map(1..5, fn i ->
  Task.async(fn ->
    :timer.sleep(1000)
    i * 2
  end)
end)

results = Enum.map(tasks, &Task.await/1)
# [2, 4, 6, 8, 10] - all computed in parallel
```

---

## Distributed Nodes

Elixir can run on multiple connected nodes:

```bash
# Start first node
$ iex --sname node1

# Start second node
$ iex --sname node2

# In node1
iex(node1@host)> Node.list()
[]

iex(node1@host)> Node.connect(:node2@host)
true

iex(node1@host)> Node.list()
[:node2@host]
```

---

## Remote Process Execution

Execute code on remote nodes:

```elixir
# Spawn process on remote node
iex(node1)> pid = Node.spawn(:node2@host, fn ->
...>   IO.puts("Running on #{node()}")
...> end)
Running on node2@host

# Call function remotely
iex(node1)> :rpc.call(:node2@host, IO, :puts, ["Hello from node1"])
Hello from node1
:ok

# Spawn linked process on remote node
iex(node1)> pid = Node.spawn_link(:node2@host, fn ->
...>   IO.puts("Linked process on #{node()}")
...> end)
```

---

## Distributed Message Passing

Send messages across nodes:

```elixir
# On node2: Start a receiver
defmodule Receiver do
  def start do
    spawn(__MODULE__, :loop, [])
  end
  
  def loop do
    receive do
      {from, msg} ->
        send(from, {:response, "Echo: #{msg}"})
        loop()
    end
  end
end

# On node1: Send message to node2
iex(node1)> pid = :rpc.call(:node2@host, Receiver, :start, [])
iex(node1)> send(pid, {self(), "Hello"})
iex(node1)> flush()
{:response, "Echo: Hello"}
```

---

## ETS: Erlang Term Storage

In-memory key-value storage:

```elixir
# Create ETS table
iex> :ets.new(:my_table, [:named_table, :public])
:my_table

# Insert data
iex> :ets.insert(:my_table, {:key1, "value1"})
true
iex> :ets.insert(:my_table, {:key2, 42})
true

# Lookup data
iex> :ets.lookup(:my_table, :key1)
[key1: "value1"]

# Delete data
iex> :ets.delete(:my_table, :key1)
true
```

---

## ETS Table Types

Different table types for different use cases:

```elixir
# Set: One value per key (default)
:ets.new(:set_table, [:set, :public, :named_table])

# Ordered Set: Sorted by key
:ets.new(:ordered_table, [:ordered_set, :public, :named_table])

# Bag: Multiple values per key
:ets.new(:bag_table, [:bag, :public, :named_table])
:ets.insert(:bag_table, {:user, "Alice"})
:ets.insert(:bag_table, {:user, "Bob"})
:ets.lookup(:bag_table, :user)
# [user: "Alice", user: "Bob"]

# Duplicate Bag: Multiple identical values allowed
:ets.new(:dup_bag, [:duplicate_bag, :public, :named_table])
```

---

## Practical Recipe: Multiple Calculations

Parallel computation with processes:

```elixir
defmodule MultipleCalculations do
  def parallel_map(collection, func) do
    collection
    |> Enum.map(&Task.async(fn -> func.(&1) end))
    |> Enum.map(&Task.await/1)
  end
  
  def calculate(numbers) do
    parallel_map(numbers, fn n ->
      # Simulate expensive calculation
      :timer.sleep(100)
      n * n
    end)
  end
end

iex> MultipleCalculations.calculate([1, 2, 3, 4, 5])
# Returns in ~100ms instead of ~500ms
[1, 4, 9, 16, 25]
```

---

## Practical Recipe: Phone Book with ETS

Using ETS for fast lookups:

```elixir
defmodule PhoneBook do
  def new do
    :ets.new(:phone_book, [:named_table, :public])
  end
  
  def add(name, number) do
    :ets.insert(:phone_book, {name, number})
  end
  
  def lookup(name) do
    case :ets.lookup(:phone_book, name) do
      [{^name, number}] -> {:ok, number}
      [] -> {:error, :not_found}
    end
  end
  
  def all do
    :ets.tab2list(:phone_book)
  end
end
```

---

## Key Takeaways

- Processes are lightweight and isolated units of concurrency
- Message passing is asynchronous and decoupled
- `spawn` creates processes, `send` and `receive` enable communication
- Links and monitors detect process failures
- Agent provides simple state management
- Task simplifies async computation
- Nodes enable distributed computing
- ETS provides fast in-memory storage
- Elixir makes concurrency approachable

---

## Best Practices

- Use processes for concurrent, independent tasks
- Keep process messages simple and well-defined
- Monitor processes to detect failures
- Use Agent for simple state, GenServer for complex state
- Leverage Task for parallel computations
- Use ETS for fast, shared data access
- Design for distribution from the start
- Handle process failures gracefully
