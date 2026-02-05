---
marp: true
theme: default
class: invert
paginate: true
---

# Chapter 1: Command Line

*Interactive Elixir and Mix Build Tool*

---

## Chapter Overview

- Using the terminal to prototype and test ideas
- Loading and compiling modules in IEx
- Getting help in IEx
- Creating simple applications with Mix
- Creating supervised applications
- Managing dependencies
- Creating custom Mix tasks

---

## Introduction

The command line is the **preferred way** to:
- Create and interact with Elixir applications
- Inspect running systems
- Prototype ideas quickly

**Two main tools:**
- **IEx** - Interactive Elixir REPL
- **Mix** - Build tool for projects

---

## Interactive Elixir (IEx)

**What is IEx?**
- REPL: **R**ead-**E**val-**P**rint-**L**oop
- Immediate evaluation of expressions
- Define modules without saving to files
- Similar to Ruby's IRB or Clojure's REPL

**Why use IEx?**
- Test code instantly
- Experiment without compilation overhead
- Get immediate feedback

---

## Starting IEx

**Getting ready:**
- Elixir must be installed
- Visit: `elixir-lang.org/install.html`
- Erlang is the only prerequisite

**How to start:**
```bash
$ iex
```

---

## Evaluating Expressions in IEx

**Basic arithmetic and variables:**

```elixir
iex(1)> a = 2 + 2
4
iex(2)> b = a * a
16
iex(3)> a + b
20
```

**How it works:**
- Expressions are evaluated as you type
- Instant feedback without file editing
- Variables persist within the session

---

## Anonymous Functions in IEx

**Defining an anonymous function:**

```elixir
iex(5)> sum = fn(a, b) -> a + b end
#Function<...>
```

**Invoking the function:**

```elixir
iex(6)> sum.(1, 2)
3
```

**Note:** Use the dot notation `.(args)` to call anonymous functions

---

## Exiting IEx

**How to quit:**
- Press **Ctrl + C** twice

**Alternative:**
- Type `System.halt()` or `System.stop()`

---

## Mix Build Tool

**What is Mix?**
- Build tool for Elixir projects
- Provides tasks for common operations
- Manages dependencies
- Supports custom task creation

**Core capabilities:**
- Create projects
- Compile code
- Run tests
- Handle dependencies

---

## Creating Simple Applications

**Command:**
```bash
$ mix new my_app
```

**What it creates:**
- Project directory structure
- Configuration files
- Basic module templates
- Test framework setup
- README.md

**Project structure:**
```
my_app/
  ├── lib/
  ├── test/
  ├── mix.exs
  └── README.md
```

---

## Creating Supervised Applications

**Command:**
```bash
$ mix new my_app --sup
```

**What's different:**
- Includes OTP application supervisor
- Application callback module
- Supervision tree ready
- Better for production systems

**Use when:**
- Building fault-tolerant applications
- Need process supervision
- Creating long-running services

---

## Managing Dependencies

**In mix.exs:**
```elixir
defp deps do
  [
    {:httpoison, "~> 1.8"},
    {:poison, "~> 5.0"}
  ]
end
```

**Commands:**
```bash
$ mix deps.get      # Fetch dependencies
$ mix deps.compile  # Compile dependencies
$ mix deps.update   # Update dependencies
```

---

## Custom Mix Tasks

**Why create custom tasks?**
- Automate repetitive operations
- Project-specific workflows
- Extend Mix functionality

**Example use cases:**
- Display memory usage
- Database migrations (Phoenix)
- Code generation
- Deployment scripts

**Phoenix framework** provides many custom Mix tasks

---

## Key Takeaways

✓ **IEx** enables rapid prototyping and testing
✓ Define and test code **without compilation**
✓ **Mix** simplifies project management
✓ Create **simple** or **supervised** applications easily
✓ Manage **dependencies** declaratively
✓ Extend Mix with **custom tasks**
✓ Command line is the **foundation** of Elixir workflow

---

## Resources

**Official Documentation:**
- IEx: `hexdocs.pm/iex`
- Mix: `hexdocs.pm/mix`

**Installation:**
- `elixir-lang.org/install.html`

**Getting Help in IEx:**
```elixir
iex> h String.split
iex> i "hello"
```
