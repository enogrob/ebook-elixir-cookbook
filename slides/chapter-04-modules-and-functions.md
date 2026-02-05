---
marp: true
theme: default
class: invert
paginate: true
---

# Chapter 4: Modules and Functions

**Elixir Cookbook**
Paulo A. Pereira

---

## Overview

- Namespacing modules
- Using module attributes as constants
- Enforcing behaviors
- Documenting modules and functions
- Module directives (use, import, alias, require)
- Defining functions with default arguments
- Pattern matching and guard clauses in functions

---

## Namespacing Modules

Organize code with nested module names using dot notation:

```elixir
defmodule MyApp.Math.Addition do
  def add(a, b), do: a + b
end

defmodule MyApp.Math.Subtraction do
  def subtract(a, b), do: a - b
end

# Usage
iex> MyApp.Math.Addition.add(1, 2)
3
iex> MyApp.Math.Subtraction.subtract(5, 3)
2
```

Benefits:
- Logical code organization
- Avoid name collisions
- Clear module hierarchy

---

## Module Attributes as Constants

Use `@` to define module-level constants:

```elixir
defmodule MyApp.Constants do
  @pi 3.14159
  @e 2.71828
  @default_timeout 5000

  def pi, do: @pi
  def e, do: @e
  
  def calculate_circle_area(radius) do
    @pi * radius * radius
  end
end

iex> MyApp.Constants.pi()
3.14159
iex> MyApp.Constants.calculate_circle_area(2)
12.56636
```

---

## Common Module Attributes

Special attributes with specific purposes:

```elixir
defmodule MyApp.Example do
  @moduledoc "Module documentation"
  @doc "Function documentation"
  @behaviour GenServer  # Implements GenServer behavior
  @vsn "1.0"           # Module version
  @external_resource "data.txt"  # Recompile on change
  
  @compile :inline    # Compilation directive
  @deprecated "Use new_function/1 instead"
  
  # Custom attributes
  @author "Paulo Pereira"
  @status :experimental
end
```

---

## Enforcing Behaviors

Behaviors define contracts (like interfaces):

```elixir
defmodule MyApp.Parser do
  @callback parse(String.t()) :: {:ok, any()} | {:error, String.t()}
  @callback format(any()) :: String.t()
end

defmodule MyApp.JSONParser do
  @behaviour MyApp.Parser
  
  def parse(string), do: Jason.decode(string)
  def format(data), do: Jason.encode!(data)
end

defmodule MyApp.XMLParser do
  @behaviour MyApp.Parser
  
  def parse(string), do: SweetXml.parse(string)
  def format(data), do: SweetXml.to_xml(data)
end
```

---

## Documenting Modules

Use `@moduledoc` and `@doc` for documentation:

```elixir
defmodule MyApp.Calculator do
  @moduledoc """
  Provides basic mathematical operations.
  
  ## Examples
      iex> MyApp.Calculator.add(1, 2)
      3
  """
  
  @doc """
  Adds two numbers together.
  
  ## Parameters
    - a: First number
    - b: Second number
    
  ## Examples
      iex> MyApp.Calculator.add(5, 3)
      8
  """
  def add(a, b), do: a + b
end
```

Generate docs: `mix docs`

---

## Module Directives: alias

Create shortcuts for module names:

```elixir
defmodule MyApp.Controller do
  # Long form
  alias MyApp.Services.UserService
  alias MyApp.Services.EmailService
  
  # With 'as'
  alias MyApp.Services.NotificationService, as: NS
  
  # Multiple aliases
  alias MyApp.Services.{UserService, EmailService, AuthService}
  
  def notify_user(user_id) do
    user = UserService.get(user_id)
    EmailService.send(user.email)
    NS.send_push(user_id)
  end
end
```

---

## Module Directives: import

Import functions from other modules:

```elixir
defmodule MyApp.ListHelper do
  # Import all functions
  import List
  
  # Import specific functions
  import Enum, only: [map: 2, filter: 2]
  
  # Import except certain functions
  import String, except: [trim: 1]
  
  def process(list) do
    list
    |> flatten()        # from List
    |> map(&(&1 * 2))   # from Enum
    |> filter(&(&1 > 5)) # from Enum
  end
end
```

---

## Module Directives: require

Load macros from other modules:

```elixir
defmodule MyApp.Logger do
  require Logger
  
  def log_info(message) do
    Logger.info("Application: #{message}")
  end
  
  def log_error(error) do
    Logger.error("Error occurred: #{inspect(error)}")
  end
end

# Required for using macros
defmodule MyApp.Conditional do
  require Integer
  
  def check(n) when Integer.is_even(n), do: :even
  def check(_), do: :odd
end
```

---

## Module Directives: use

Inject code into the current module:

```elixir
# Defining a module that can be 'used'
defmodule MyApp.CommonBehavior do
  defmacro __using__(opts) do
    quote do
      @behaviour MyApp.Parser
      
      def default_timeout, do: unquote(opts[:timeout] || 5000)
      
      defoverridable [default_timeout: 0]
    end
  end
end

# Using it
defmodule MyApp.MyParser do
  use MyApp.CommonBehavior, timeout: 10_000
  
  # Gets injected behavior and functions
end
```

---

## Default Arguments

Define default values with `\\`:

```elixir
defmodule Greeter do
  def greet(name \\ "World") do
    "Hello, #{name}!"
  end
  
  def introduce(name, age \\ 18, city \\ "Unknown") do
    "#{name}, age #{age}, from #{city}"
  end
end

iex> Greeter.greet()
"Hello, World!"
iex> Greeter.greet("Alice")
"Hello, Alice!"
iex> Greeter.introduce("Bob")
"Bob, age 18, from Unknown"
iex> Greeter.introduce("Carol", 25, "NYC")
"Carol, age 25, from NYC"
```

---

## Pattern Matching in Function Definitions

Multiple function clauses with pattern matching:

```elixir
defmodule MyApp.Math do
  # Pattern match on list structure
  def sum([]), do: 0
  def sum([head | tail]), do: head + sum(tail)
  
  # Pattern match on tuples
  def handle_result({:ok, value}), do: "Success: #{value}"
  def handle_result({:error, reason}), do: "Error: #{reason}"
  
  # Pattern match on maps
  def greet(%{name: name}), do: "Hello, #{name}"
  def greet(%{first: first, last: last}), do: "Hello, #{first} #{last}"
  
  # Pattern match on specific values
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n - 1) + fib(n - 2)
end
```

---

## Guard Clauses

Add conditions to function clauses with `when`:

```elixir
defmodule MyApp.Validator do
  # Type guards
  def check(x) when is_integer(x), do: "Integer: #{x}"
  def check(x) when is_float(x), do: "Float: #{x}"
  def check(x) when is_binary(x), do: "String: #{x}"
  
  # Comparison guards
  def classify(x) when x < 0, do: :negative
  def classify(0), do: :zero
  def classify(x) when x > 0, do: :positive
  
  # Complex guards
  def valid_age?(age) when is_integer(age) and age >= 0 and age <= 120 do
    true
  end
  def valid_age?(_), do: false
end
```

---

## Advanced Guards

Combining pattern matching and guards:

```elixir
defmodule MyApp.Advanced do
  # Multiple conditions
  def describe(x) when is_integer(x) and x > 0 and rem(x, 2) == 0 do
    "Positive even integer"
  end
  
  # Pattern match + guards
  def process([head | tail]) when is_integer(head) and head > 0 do
    [head * 2 | process(tail)]
  end
  def process([_ | tail]), do: process(tail)
  def process([]), do: []
  
  # Map patterns + guards
  def adult?(%{age: age}) when age >= 18, do: true
  def adult?(_), do: false
end
```

---

## Private Functions

Define internal functions with `defp`:

```elixir
defmodule MyApp.Calculator do
  # Public API
  def calculate(a, b, operation) do
    case operation do
      :add -> add(a, b)
      :multiply -> multiply(a, b)
      _ -> {:error, :unknown_operation}
    end
  end
  
  # Private helper functions
  defp add(a, b), do: a + b
  defp multiply(a, b), do: a * b
end

# add/2 and multiply/2 are not accessible outside the module
```

---

## Anonymous Functions

Functions without names:

```elixir
# Basic anonymous function
iex> add = fn a, b -> a + b end
iex> add.(1, 2)
3

# Multiple clauses
iex> handle = fn
...>   {:ok, result} -> "Success: #{result}"
...>   {:error, reason} -> "Error: #{reason}"
...> end

# Capture syntax
iex> multiply_by_two = &(&1 * 2)
iex> multiply_by_two.(5)
10

iex> add = &(&1 + &2)
iex> add.(3, 4)
7
```

---

## Function Capturing

Capture existing functions:

```elixir
# Capture module functions
iex> upcase = &String.upcase/1
iex> upcase.("hello")
"HELLO"

iex> add = &Kernel.+/2
iex> add.(1, 2)
3

# Use in higher-order functions
iex> Enum.map([1, 2, 3], &(&1 * 2))
[2, 4, 6]

iex> Enum.map(["a", "b", "c"], &String.upcase/1)
["A", "B", "C"]
```

---

## Recursion

Elixir relies heavily on recursion:

```elixir
defmodule MyApp.Recursive do
  # Factorial
  def factorial(0), do: 1
  def factorial(n) when n > 0, do: n * factorial(n - 1)
  
  # Tail-call optimized version
  def factorial_tco(n), do: factorial_tco(n, 1)
  defp factorial_tco(0, acc), do: acc
  defp factorial_tco(n, acc), do: factorial_tco(n - 1, n * acc)
  
  # List length
  def length([]), do: 0
  def length([_ | tail]), do: 1 + length(tail)
end
```

---

## Key Takeaways

- Modules organize code with namespacing
- Module attributes serve as constants and metadata
- Behaviors define contracts for modules
- Documentation is first-class with `@moduledoc` and `@doc`
- Directives (alias, import, require, use) manage dependencies
- Functions support default arguments with `\\`
- Pattern matching in function definitions is powerful
- Guard clauses add conditions to function clauses
- Private functions use `defp`
- Recursion is the primary iteration mechanism

---

## Best Practices

- Use descriptive module names with namespacing
- Document all public functions
- Keep functions small and focused
- Leverage pattern matching over conditionals
- Use guards for type and value checks
- Prefer tail-call optimized recursion
- Make helper functions private
- Use the pipeline operator for clarity
