---
chapter: 6
title: OTP – Open Telecom Platform
total_cards: 20
created_date: 2026-02-04
---

## OTP Basics

**Q: What is OTP?**  
A: OTP (Open Telecom Platform) is a set of design principles, libraries, and patterns for building robust, fault-tolerant, and scalable systems.  
Difficulty: Beginner | Tags: otp, frameworks

**Q: What does OTP provide?**  
A: OTP provides behaviors (like GenServer, Supervisor), design patterns, and a systematization of common programming concepts.  
Difficulty: Intermediate | Tags: otp, components

**Q: Is OTP only for telecom applications?**  
A: No, despite the name, OTP is a general-purpose framework for building any kind of robust distributed system.  
Difficulty: Beginner | Tags: otp, history

## GenServer

**Q: What is a GenServer?**  
A: GenServer (Generic Server) is an OTP behavior that abstracts the common server pattern for handling synchronous and asynchronous requests.  
Difficulty: Intermediate | Tags: genserver, behaviors

**Q: What callbacks must a GenServer implement?**  
A: At minimum: `init/1`, and typically `handle_call/3` and `handle_cast/2` for handling requests.  
Difficulty: Intermediate | Tags: genserver, callbacks

**Q: What's the difference between `handle_call` and `handle_cast`?**  
A: `handle_call` is for synchronous requests that expect a reply, while `handle_cast` is for asynchronous requests without replies.  
Difficulty: Intermediate | Tags: genserver, patterns

**Q: How do you start a GenServer?**  
A: Use `GenServer.start_link/3`: `GenServer.start_link(MyServer, init_arg, name: :my_server)`.  
Difficulty: Intermediate | Tags: genserver, initialization

**Q: What does the `init/1` callback do in a GenServer?**  
A: Initializes the server's state and returns `{:ok, initial_state}`.  
Difficulty: Intermediate | Tags: genserver, initialization

## Supervisors

**Q: What is a Supervisor?**  
A: A Supervisor is a process that monitors other processes (its children) and restarts them if they crash.  
Difficulty: Intermediate | Tags: supervisors, fault-tolerance

**Q: What are the main supervisor strategies?**  
A: `:one_for_one`, `:one_for_all`, `:rest_for_one`, and `:simple_one_for_one`.  
Difficulty: Advanced | Tags: supervisors, strategies

**Q: What does the :one_for_one strategy do?**  
A: If a child process crashes, only that process is restarted - other children continue running.  
Difficulty: Intermediate | Tags: supervisors, strategies

**Q: What does the :one_for_all strategy do?**  
A: If one child crashes, all children are terminated and restarted.  
Difficulty: Intermediate | Tags: supervisors, strategies

**Q: How do you define a supervisor?**  
A: Use `Supervisor.start_link/2` with a list of child specifications and a strategy.  
Difficulty: Intermediate | Tags: supervisors, initialization

## Supervision Trees

**Q: What is a supervision tree?**  
A: A hierarchical structure where supervisors monitor workers and other supervisors, creating a fault-tolerant architecture.  
Difficulty: Intermediate | Tags: supervision-trees, architecture

**Q: Why are supervision trees important?**  
A: They provide fault isolation and recovery, allowing parts of the system to fail and restart without affecting the whole system.  
Difficulty: Intermediate | Tags: supervision-trees, fault-tolerance

## Applications

**Q: What is an OTP application?**  
A: An application is a bundled package of code with a defined structure, including modules, configuration, and resources.  
Difficulty: Intermediate | Tags: applications, otp

**Q: What file defines an OTP application?**  
A: The `mix.exs` file defines the application structure, dependencies, and configuration.  
Difficulty: Beginner | Tags: applications, configuration

**Q: What is the application callback module?**  
A: A module that implements the `Application` behavior and defines how the application starts its supervision tree.  
Difficulty: Advanced | Tags: applications, callbacks

## Fault Tolerance

**Q: What is the "let it crash" philosophy?**  
A: Instead of defensive programming, let processes crash and rely on supervisors to restart them in a clean state.  
Difficulty: Intermediate | Tags: philosophy, fault-tolerance

**Q: How do supervisors contribute to fault tolerance?**  
A: Supervisors automatically detect and restart failed processes, isolating failures and maintaining system availability.  
Difficulty: Intermediate | Tags: supervisors, fault-tolerance

**Q: What makes OTP systems resilient?**  
A: Process isolation, supervision trees, automatic restarts, and the "let it crash" philosophy create self-healing systems.  
Difficulty: Advanced | Tags: otp, resilience
