
## Chapter 1: Command Line

This chapter covers the following recipes:

- **Interactive Elixir (IEx):**
  - Using the terminal to prototype and test ideas
  - Loading and compiling modules
  - Getting help and accessing documentation within IEx
  - Using Erlang from Elixir
  - Inspecting your system in IEx
  - Inspecting your system with Observer

- **Mix:**
  - Creating a simple application
  - Managing dependencies
  - Generating a supervised application
  - Generating umbrella applications
  - Managing application configuration
  - Creating custom Mix tasks

---

### Introduction

The command line is the preferred way to create and interact with Elixir applications, inspect running systems, and prototype ideas.

**Interactive Elixir (IEx)** allows immediate evaluation of any expression, and it is possible to define modules directly without saving them to a file.  
**Mix** is a build tool that provides tasks to create, compile, and test projects, and handle dependencies. You can also define custom tasks with Mix.

---

### Using the terminal to prototype and test ideas

Elixir provides an REPL called IEx. It allows you to test code and even create entire modules without compiling a source file.

**Getting ready**

- Install Elixir (see: http://elixir-lang.org/install.html).
- Install Erlang (the only prerequisite).

**How to do it…**

1. Start IEx:
	```
	iex
	```
2. Type some expressions:
	```
	iex(1)> a = 2 + 2
	4

	iex(2)> b = a * a
	16

	iex(3)> a + b
	20
	```
3. Define an anonymous function:
	```
	iex(4)> sum = fn(a, b) -> a + b end
	#Function<...>
	```
4. Invoke the function:
	```
	iex(5)> sum.(1, 2)
	3
	```
5. Quit IEx: Press `Ctrl + C` twice.

**How it works…**

- IEx evaluates expressions as they are typed, allowing instant feedback.
- The `=` operator is a pattern matching operator, not assignment.
- Anonymous functions are called with a dot: `sum.(1, 2)`.

**There's more…**

- You can define modules inside IEx.

---

### Loading and compiling modules

You can load code from source files into an IEx session.

**Getting ready**

Suppose you have these files:

`greeter.ex`
```elixir
defmodule Greeter do
  def greet(name \\ "you") do
	 "Hello #{name} !"
  end
end
```

`echoer.ex`
```elixir
defmodule Echoer do
  def echo(msg) do
	 IO.puts "#{msg} ... #{msg} ...... #{msg}"
  end
end
```

**How to do it…**

1. Start IEx:
	```
	iex
	```
2. Load the Greeter module:
	```
	iex(1)> c("greeter.ex")
	[Greeter]
	```
3. Load the Echoer module:
	```
	iex(2)> c("echoer.ex")
	[Echoer]
	```
4. Use the modules:
	```
	iex(3)> Greeter.greet("Me")
	"Hello Me !"

	iex(4)> Echoer.echo("hello")
	hello ... hello ...... hello
	:ok

	iex(5)> Greeter.greet("Me") |> Echoer.echo
	Hello Me ! ... Hello Me ! ...... Hello Me !
	:ok
	```

**How it works…**

- `c("file.ex")` loads and compiles the file.
- Modules become available in the session.
- The pipe operator (`|>`) feeds the output of the left operation as the first argument to the right.

**There's more…**

- You can use relative or full paths in `c("path/to/file.ex")`.

---

### Getting help and accessing documentation within IEx

Documentation is a first-class citizen in Elixir. IEx provides ways to access documentation and get help.

**How to do it…**

1. Enter `h` in IEx to see help options.
2. Get info about a function:
	```
	iex> h(c/2)
	```
3. Access module documentation:
	```
	iex> h(Enum)
	```
4. Get info about a specific function:
	```
	iex> h(Enum.map)
	```

**How it works…**

- Use `@moduledoc` and `@doc` in your modules/functions to provide documentation.
- IEx parses and displays this documentation with the `h` helper.

**There's more…**

- Use `s/1` and `t/1` in IEx to get information on function specifications and types.

---

### Using Erlang from Elixir

Elixir code runs in the Erlang VM. You can invoke Erlang code from within Elixir.

**How to do it…**

1. Call an Erlang function:
	```
	iex(1)> :application.which_applications
	```
2. Get module info:
	```
	iex(2)> :erlang.module_info
	```

**How it works…**

- Erlang modules are represented as atoms in Elixir.
- Functions are invoked as `:module.function(args)`.

**There's more…**

- You can use Erlang libraries in Elixir applications.
- Example: `List.last([1,2,3])` (Elixir) vs `:lists.last([1,2,3])` (Erlang).

---

### Inspecting your system in IEx

You can inspect the running VM using Erlang modules.

**How to do it…**

1. Get running applications:
	```
	iex(1)> :application.which_applications
	```
2. Get memory usage:
	```
	iex(2)> :erlang.memory
	```
3. Get memory usage for atoms:
	```
	iex(3)> :erlang.memory(:atom)
	```

**How it works…**

- Erlang modules provide system inspection capabilities.

**See also**

- Use Observer (next recipe) for a GUI view.

---

### Inspecting your system with Observer

Observer is a GUI tool for inspecting the Erlang VM.

**How to do it…**

1. Start IEx.
2. Start Observer:
	```
	iex(1)> :observer.start
	```
3. Use the GUI to inspect system stats, memory, applications, and process hierarchies.

---

### Creating a simple application

Use Mix to create a new Elixir application.

**How to do it…**

1. List available Mix tasks:
	```
	> mix help
	```
2. Generate a new application:
	```
	> mix new simple_app
	```
3. Start the app:
	```
	> cd simple_app
	> iex -S mix
	```
4. Edit `lib/simple_app.ex`:
	```elixir
	defmodule SimpleApp do
	  def greet do
		 IO.puts "Hello from Simple App!"
	  end
	end
	```
5. Restart and test:
	```
	iex(1)> SimpleApp.greet
	Hello from Simple App!
	:ok
	```

**How it works…**

- Mix is a build tool for Elixir, providing tasks for creating, managing, and running applications.

---

### Managing dependencies

Add dependencies to your application using Hex.

**How to do it…**

1. Generate a new app:
	```
	> mix new manage_deps
	```
2. Add a dependency in `mix.exs`:
	```elixir
	defp deps do
	  [{:httpoison, "~> 0.4"}]
	end
	```
3. Add to applications:
	```elixir
	def application do
	  [applications: [:logger, :httpoison]]
	end
	```
4. Fetch and compile dependencies:
	```
	> mix deps.get
	> mix deps.compile
	```
5. Start your app:
	```
	> iex -S mix
	```
6. Test the dependency:
	```
	iex(1)> HTTPoison.get("http://www.google.com")
	```

**How it works…**

- Dependencies are managed via Hex or GitHub.
- Use `mix deps.get` and `mix deps.compile` to fetch and build them.

---

### Generating a supervised application

Generate an application with a supervision tree.

**How to do it…**

1. Generate with supervisor:
	```
	> mix new supervised_app --sup
	```

**How it works…**

- The `--sup` flag adds a supervision tree and an application module callback.

---

### Generating umbrella applications

Umbrella applications group multiple apps together.

**How to do it…**

1. Generate umbrella:
	```
	> mix new --umbrella container
	```
2. Create sub-apps:
	```
	> cd container/apps
	> mix new application_one
	> mix new application_two
	```
3. Run tests at the umbrella or sub-app level.

**How it works…**

- Umbrella projects make it easy to manage multiple related applications.

---

### Managing application configuration

Configure your app for different environments.

**How to do it…**

1. Create a new app:
	```
	> mix new config_example
	```
2. Edit `config/config.exs`:
	```elixir
	use Mix.Config

	config :config_example,
	  message_one: "This is a shared message!"

	import_config "#{Mix.env}.exs"
	```
3. Add `dev.exs`, `prod.exs`, and `test.exs` with environment-specific configs.
4. Access config in your module:
	```elixir
	@message_one Application.get_env(:config_example, :message_one)
	@message_two Application.get_env(:config_example, :message_two)
	```
5. Test in different environments:
	```
	> MIX_ENV=dev iex -S mix
	> MIX_ENV=prod iex -S mix
	> MIX_ENV=test iex -S mix
	```

**How it works…**

- `import_config "#{Mix.env}.exs"` loads environment-specific configs.
- Use `Application.get_env/2` to access config values.

---

### Creating custom Mix tasks

You can create your own Mix tasks.

**How to do it…**

1. Create `meminfo.ex`:
	```elixir
	defmodule Mix.Tasks.Meminfo do
	  use Mix.Task
	  @shortdoc "Get Erlang VM memory usage information"
	  @moduledoc """
	  A mix custom task that outputs some information regarding
	  the Erlang VM memory usage
	  """
	  def run(_) do
		 meminfo = :erlang.memory
		 IO.puts """
		 Total            #{meminfo[:total]}
		 Processes        #{meminfo[:processes]}
		 Processes (used) #{meminfo[:processes_used]}
		 System           #{meminfo[:system]}
		 Atom             #{meminfo[:atom]}
		 Atom (used)      #{meminfo[:atom_used]}
		 Binary           #{meminfo[:binary]}
		 Code             #{meminfo[:code]}
		 ETS              #{meminfo[:ets]}
		 """
	  end
	end
	```
2. Compile:
	```
	elixirc meminfo.ex
	```
3. See the new task:
	```
	> mix help
	```
4. Run the task:
	```
	> mix meminfo
	```

**How it works…**

- Custom Mix tasks are modules under `Mix.Tasks.*` with a `run/1` function.

---

**End of Chapter 1**
