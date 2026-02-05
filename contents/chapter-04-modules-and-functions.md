# Chapter 04: Modules and Functions

## Summary

Chapter 4 covers the fundamental building blocks of Elixir applications: modules and functions. It explores module organization through namespacing, the use of module attributes as constants, behavior enforcement, documentation practices, and module directives (use, import, alias, require). The chapter also demonstrates defining functions with default arguments, using guard clauses for additional constraints, and pattern matching in function definitions for expressive and robust code. These concepts enable developers to create well-structured, maintainable, and documented Elixir applications.

## Concepts Map

```mermaid
%%{init: {'theme':'base','themeVariables':{'primaryColor':'#E8F4FD','primaryBorderColor':'#4A90E2','primaryTextColor':'#2C3E50','secondaryColor':'#F0F8E8','tertiaryColor':'#FDF2E8','quaternaryColor':'#F8E8F8','lineColor':'#5D6D7E','fontFamily':'Inter,Segoe UI,Arial'}}}%%
graph TB
    A[Modules & Functions] --> B[Module Organization]
    A --> C[Module Features]
    A --> D[Function Features]
    A --> E[Directives]
    
    B --> F[Namespacing]
    B --> G[Module Nesting]
    
    C --> H[Module Attributes]
    C --> I[Behaviors]
    C --> J[Documentation]
    
    D --> K[Default Arguments]
    D --> L[Guard Clauses]
    D --> M[Pattern Matching]
    D --> N[Multiple Clauses]
    
    E --> O[use]
    E --> P[import]
    E --> Q[alias]
    E --> R[require]
    
    H --> S[@moduledoc]
    H --> T[@doc]
    H --> U[Constants]
    
    I --> V[@behaviour]
    I --> W[@callback]
    
    K --> X[Backslash Syntax]
    L --> Y[when keyword]
    M --> Z[Function Heads]
    
    style A fill:#4A90E2,color:#fff
    style B fill:#E8F4FD
    style C fill:#F0F8E8
    style D fill:#FDF2E8
    style E fill:#F8E8F8
```

## Key Concepts

- **Modules**: Containers for organizing related functions, constants, and attributes
- **Namespacing**: Organizing modules hierarchically using dot notation (e.g., `MyApp.Math.Addition`)
- **Module Attributes**: Metadata and constants prefixed with `@` symbol
- **Behaviors**: Interface-like contracts defining required callbacks (similar to interfaces)
- **@callback**: Defines required function signatures for behaviors
- **@behaviour**: Declares that a module implements a specific behavior
- **Documentation**: Using `@moduledoc` and `@doc` for inline documentation
- **Module Directives**: Keywords for bringing in external functionality (`use`, `import`, `alias`, `require`)
- **Default Arguments**: Function parameters with default values using `\\` syntax
- **Guard Clauses**: Additional constraints on function parameters using `when` keyword
- **Pattern Matching in Functions**: Multiple function clauses matching different argument patterns
- **Function Arity**: Number of arguments a function accepts, denoted as `function/arity`
- **Private Functions**: Functions prefixed with `defp` that are module-internal only

## Quiz (20260204_120300)

1. What is a module in Elixir?
   - [ ] A. A type of variable
   - [x] B. A container for organizing functions and constants
   - [ ] C. A loop structure
   - [ ] D. A data type

2. How do you namespace modules in Elixir?
   - [ ] A. Using underscores: `My_App_Module`
   - [x] B. Using dot notation: `MyApp.Module`
   - [ ] C. Using slashes: `MyApp/Module`
   - [ ] D. Using colons: `MyApp::Module`

3. What symbol prefixes module attributes?
   - [ ] A. `#`
   - [ ] B. `$`
   - [x] C. `@`
   - [ ] D. `%`

4. What is a behavior in Elixir?
   - [x] A. An interface-like contract defining required callbacks
   - [ ] B. How a function behaves
   - [ ] C. A type of loop
   - [ ] D. A module attribute

5. Which directive creates a shortcut for a module name?
   - [ ] A. `use`
   - [ ] B. `import`
   - [x] C. `alias`
   - [ ] D. `require`

6. How do you define default arguments in functions?
   - [ ] A. Using `default` keyword
   - [x] B. Using `\\` syntax
   - [ ] C. Using `=` in parameters
   - [ ] D. Using `?` suffix

7. What keyword introduces guard clauses?
   - [ ] A. `if`
   - [ ] B. `guard`
   - [x] C. `when`
   - [ ] D. `check`

8. What does `@doc` do?
   - [ ] A. Imports documentation
   - [x] B. Documents a function
   - [ ] C. Creates a document
   - [ ] D. Nothing, it's just a comment

9. How do you define a private function?
   - [ ] A. `def private_func`
   - [x] B. `defp private_func`
   - [ ] C. `def _private_func`
   - [ ] D. `private def func`

10. What is function arity?
    - [ ] A. Function complexity
    - [ ] B. Function speed
    - [x] C. Number of arguments a function accepts
    - [ ] D. Function type

### Answers
1. B, 2. B, 3. C, 4. A, 5. C, 6. B, 7. C, 8. B, 9. B, 10. C

## Challenge

**Task**: Create a comprehensive module demonstrating all the concepts covered in this chapter.

Implement a module called `Calculator` that:
1. Uses namespacing under `MathTools.Calculator`
2. Defines module attributes for constants (e.g., `@pi`)
3. Implements a behavior for mathematical operations
4. Includes documentation for the module and functions
5. Uses module directives appropriately
6. Has functions with default arguments
7. Uses guard clauses for input validation
8. Uses pattern matching for different input scenarios

### Answer

```elixir
# First, define a behavior
defmodule MathTools.Operation do
  @moduledoc """
  Behavior for mathematical operations.
  """
  
  @callback calculate(number, number) :: number
  @callback describe() :: String.t()
end

# Main calculator module
defmodule MathTools.Calculator do
  @moduledoc """
  A comprehensive calculator module demonstrating Elixir module and function features.
  
  ## Examples
  
      iex> MathTools.Calculator.add(2, 3)
      5
      
      iex> MathTools.Calculator.circle_area(5)
      78.53981633974483
  """
  
  # Module attributes as constants
  @pi 3.141592653589793
  @e 2.718281828459045
  @golden_ratio 1.618033988749895
  
  # Module directives
  import Kernel, except: [div: 2]  # We'll define our own div
  alias MathTools.{Statistics, Advanced}
  require Logger
  
  @doc """
  Returns the value of PI.
  """
  def pi, do: @pi
  
  @doc """
  Returns the value of Euler's number (e).
  """
  def e, do: @e
  
  @doc """
  Adds two numbers.
  
  ## Examples
  
      iex> MathTools.Calculator.add(2, 3)
      5
  """
  def add(a, b) when is_number(a) and is_number(b) do
    a + b
  end
  
  @doc """
  Subtracts the second number from the first.
  """
  def subtract(a, b) when is_number(a) and is_number(b) do
    a - b
  end
  
  @doc """
  Multiplies two numbers.
  """
  def multiply(a, b) when is_number(a) and is_number(b) do
    a * b
  end
  
  @doc """
  Divides two numbers. Returns error tuple if dividing by zero.
  
  ## Examples
  
      iex> MathTools.Calculator.div(10, 2)
      {:ok, 5.0}
      
      iex> MathTools.Calculator.div(10, 0)
      {:error, :division_by_zero}
  """
  def div(_numerator, 0), do: {:error, :division_by_zero}
  
  def div(numerator, denominator) when is_number(numerator) and is_number(denominator) do
    {:ok, numerator / denominator}
  end
  
  @doc """
  Calculates power with optional exponent (default is 2).
  
  ## Examples
  
      iex> MathTools.Calculator.power(5)
      25
      
      iex> MathTools.Calculator.power(2, 3)
      8
  """
  def power(base, exponent \\ 2) when is_number(base) and is_number(exponent) do
    :math.pow(base, exponent)
  end
  
  @doc """
  Calculates the area of a circle using the stored PI constant.
  """
  def circle_area(radius) when is_number(radius) and radius > 0 do
    @pi * radius * radius
  end
  
  def circle_area(radius) when is_number(radius) and radius <= 0 do
    {:error, :invalid_radius}
  end
  
  @doc """
  Calculates factorial using pattern matching and recursion.
  
  ## Examples
  
      iex> MathTools.Calculator.factorial(5)
      120
      
      iex> MathTools.Calculator.factorial(0)
      1
  """
  def factorial(0), do: 1
  def factorial(1), do: 1
  
  def factorial(n) when is_integer(n) and n > 1 do
    n * factorial(n - 1)
  end
  
  def factorial(n) when is_integer(n) and n < 0 do
    {:error, :negative_number}
  end
  
  @doc """
  Determines if a number is even. Demonstrates guard clauses.
  """
  def even?(n) when is_integer(n) and rem(n, 2) == 0, do: true
  def even?(n) when is_integer(n), do: false
  def even?(_), do: {:error, :not_an_integer}
  
  @doc """
  Calculates the absolute value using pattern matching.
  """
  def abs(n) when n < 0, do: -n
  def abs(n) when n >= 0, do: n
  
  @doc """
  Performs operation based on pattern matching the operator.
  """
  def calculate(:add, a, b), do: add(a, b)
  def calculate(:subtract, a, b), do: subtract(a, b)
  def calculate(:multiply, a, b), do: multiply(a, b)
  def calculate(:divide, a, b), do: div(a, b)
  def calculate(operation, _a, _b), do: {:error, {:unknown_operation, operation}}
  
  # Private helper function
  defp log_calculation(operation, result) do
    Logger.debug("Performed #{operation}: #{result}")
    result
  end
end

# Example implementation of the behavior
defmodule MathTools.Addition do
  @behaviour MathTools.Operation
  
  @impl true
  def calculate(a, b), do: a + b
  
  @impl true
  def describe, do: "Addition operation"
end

defmodule MathTools.Multiplication do
  @behaviour MathTools.Operation
  
  @impl true
  def calculate(a, b), do: a * b
  
  @impl true
  def describe, do: "Multiplication operation"
end

# Usage examples:
# MathTools.Calculator.add(5, 3)
# => 8

# MathTools.Calculator.power(2, 8)
# => 256.0

# MathTools.Calculator.circle_area(10)
# => 314.1592653589793

# MathTools.Calculator.factorial(5)
# => 120

# MathTools.Calculator.even?(42)
# => true

# MathTools.Calculator.calculate(:multiply, 6, 7)
# => 42

# MathTools.Addition.describe()
# => "Addition operation"
```

This implementation demonstrates:
- **Namespacing**: `MathTools.Calculator` hierarchy
- **Module Attributes**: `@pi`, `@e`, `@golden_ratio` as constants
- **Behaviors**: `MathTools.Operation` behavior with implementations
- **Documentation**: `@moduledoc` and `@doc` for all public functions
- **Module Directives**: `import`, `alias`, `require` used appropriately
- **Default Arguments**: `power/2` with default exponent of 2
- **Guard Clauses**: Extensive use of `when` for validation
- **Pattern Matching**: Multiple function clauses for different scenarios
- **Private Functions**: `defp` for internal helpers
