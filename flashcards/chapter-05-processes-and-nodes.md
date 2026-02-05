---
chapter: 5
title: Processes and Nodes
total_cards: 22
created_date: 2026-02-04
---

## Process Basics

**Q: What are processes in Elixir?**  
A: Processes are lightweight, isolated units of concurrency that communicate via message passing.  
Difficulty: Intermediate | Tags: processes, concurrency

**Q: How do you spawn a new process?**  
A: Use `spawn/1` or `spawn/3`: `spawn(fn -> IO.puts("Hello") end)`.  
Difficulty: Beginner | Tags: spawn, processes

**Q: What is a PID?**  
A: A PID (Process IDentifier) is a unique identifier for each process in Elixir.  
Difficulty: Beginner | Tags: pid, processes

**Q: How do you get the PID of the current process?**  
A: Use the `self/0` function: `self()`.  
Difficulty: Beginner | Tags: pid, self

## Message Passing

**Q: How do processes communicate in Elixir?**  
A: Processes communicate by sending and receiving messages using the actor model.  
Difficulty: Intermediate | Tags: message-passing, concurrency

**Q: How do you send a message to a process?**  
A: Use the `send/2` function: `send(pid, {:hello, self()})`.  
Difficulty: Beginner | Tags: send, message-passing

**Q: How do you receive messages in a process?**  
A: Use the `receive` construct with pattern matching:
```elixir
receive do
  {:hello, sender_pid} -> IO.puts("Received hello")
end
```  
Difficulty: Intermediate | Tags: receive, message-passing

**Q: Are processes in Elixir shared-memory or message-passing based?**  
A: Message-passing. Processes don't share memory - they communicate only through messages.  
Difficulty: Intermediate | Tags: concurrency, architecture

## Process Isolation

**Q: What happens if one process crashes in Elixir?**  
A: Processes are isolated - if one crashes, it doesn't affect other processes (unless explicitly linked).  
Difficulty: Intermediate | Tags: isolation, fault-tolerance

**Q: Are Elixir processes OS threads?**  
A: No, Elixir processes are much lighter than OS threads, managed by the BEAM VM.  
Difficulty: Intermediate | Tags: processes, performance

**Q: How many processes can you typically spawn in Elixir?**  
A: Millions of processes can run concurrently on modern hardware due to their lightweight nature.  
Difficulty: Intermediate | Tags: scalability, performance

## Distributed Elixir

**Q: What is a node in distributed Elixir?**  
A: A node is an instance of the Erlang runtime system that can communicate with other nodes.  
Difficulty: Intermediate | Tags: nodes, distribution

**Q: How do you start a named node?**  
A: Use the `--sname` or `--name` flag when starting: `iex --sname node1`.  
Difficulty: Intermediate | Tags: nodes, cli

**Q: How do you connect two nodes?**  
A: Use `Node.connect/1`: `Node.connect(:node2@hostname)`.  
Difficulty: Intermediate | Tags: nodes, connection

**Q: Can you send messages to processes on other nodes?**  
A: Yes, using the same `send/2` function with a PID from another node.  
Difficulty: Intermediate | Tags: distribution, message-passing

## Process State

**Q: How do processes maintain state in Elixir?**  
A: Through recursive functions that receive messages and call themselves with updated state.  
Difficulty: Advanced | Tags: state, recursion

**Q: What is the typical pattern for a stateful process?**  
A: A recursive loop that receives messages, processes them, and recurses with new state.  
Difficulty: Advanced | Tags: patterns, state

## ETS (Erlang Term Storage)

**Q: What is ETS?**  
A: ETS is Erlang Term Storage - an in-memory database for storing large amounts of data efficiently.  
Difficulty: Intermediate | Tags: ets, storage

**Q: What are the main benefits of ETS?**  
A: Fast lookups, shared access across processes, and efficient storage of large datasets.  
Difficulty: Intermediate | Tags: ets, performance

## Asynchronous Operations

**Q: Why are processes useful for asynchronous computations?**  
A: Processes allow multiple computations to run concurrently without blocking the main process.  
Difficulty: Intermediate | Tags: async, concurrency

**Q: How does Elixir make concurrency easier than traditional threading?**  
A: Lightweight processes, message passing (no shared state), and built-in tools make concurrency simpler and safer.  
Difficulty: Advanced | Tags: concurrency, advantages

**Q: What's the advantage of message passing over shared memory?**  
A: Message passing eliminates race conditions, deadlocks, and makes reasoning about concurrent code easier.  
Difficulty: Advanced | Tags: concurrency, design
