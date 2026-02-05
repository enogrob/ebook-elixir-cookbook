---
marp: true
theme: default
class: invert
paginate: true
---

# Chapter 2: Data Types and Structures

**Elixir Cookbook**
Paulo A. Pereira

---

## Overview

- Understanding Elixir data types
- Scalar vs. Composite data types
- Immutability concepts
- Pattern matching
- Lazy evaluation
- Working with Lists, Tuples, Maps, and Keyword lists

---

## Scalar Data Types

Elixir's scalar data types represent single values:

- **Integers**: `42`, `0x2A`, `0b101010`
- **Floating-point**: `3.14`, `1.0e-10`
- **Booleans**: `true`, `false`
- **Atoms**: `:hello`, `:ok`, `:error`
- **Strings**: `"hello world"`

```elixir
iex> 1 + 1
2
iex> 3.14 * 2
6.28
iex> true and false
false
iex> :hello
:hello
```

---

## Composite Data Types: Lists

Lists are ordered collections denoted by square brackets:

```elixir
iex> list = [1, 2, 3, 4, 5]
[1, 2, 3, 4, 5]

iex> [head | tail] = list
[1, 2, 3, 4, 5]

iex> head
1

iex> tail
[2, 3, 4, 5]

iex> [0 | list]
[0, 1, 2, 3, 4, 5]
```

Lists are linked data structures, making head access O(1) and tail access O(n).

---

## Composite Data Types: Tuples

Tuples store elements contiguously in memory:

```elixir
iex> tuple = {1, 2, 3, 4, 5}
{1, 2, 3, 4, 5}

iex> tuple_size(tuple)
5

iex> elem(tuple, 0)
1

iex> put_elem(tuple, 0, 10)
{10, 2, 3, 4, 5}
```

- Fast random access
- Often used for fixed-size collections
- Common return values: `{:ok, result}`, `{:error, reason}`

---

## Composite Data Types: Maps

Maps are key-value stores denoted by `%{}`:

```elixir
iex> map = %{"a" => 1, "b" => 2, "c" => 3}
%{"a" => 1, "b" => 2, "c" => 3}

iex> map["a"]
1

iex> Map.get(map, "b")
2

iex> %{map | "a" => 10}
%{"a" => 10, "b" => 2, "c" => 3}
```

Maps with atom keys allow special syntax:

```elixir
iex> map = %{name: "John", age: 30}
iex> map.name
"John"
```

---

## Composite Data Types: Keyword Lists

Keyword lists are lists of two-element tuples:

```elixir
iex> keyword_list = [a: 1, b: 2, c: 3]
[a: 1, b: 2, c: 3]

iex> keyword_list[:a]
1

iex> Keyword.get(keyword_list, :b)
2
```

- Keys can be duplicated
- Order is preserved
- Commonly used for options and function parameters

---

## Immutability in Elixir

All data structures in Elixir are immutable:

```elixir
iex> list = [1, 2, 3]
iex> List.delete_at(list, 0)
[2, 3]
iex> list
[1, 2, 3]  # Original list unchanged
```

Benefits:
- No side effects
- Easier to reason about code
- Safe concurrent operations
- Structural sharing for efficiency

---

## Pattern Matching

Pattern matching is a powerful feature for destructuring data:

```elixir
# Matching tuples
iex> {:ok, result} = {:ok, 42}
{:ok, 42}
iex> result
42

# Matching lists
iex> [first, second | rest] = [1, 2, 3, 4, 5]
iex> first
1
iex> rest
[3, 4, 5]

# Matching maps
iex> %{name: name} = %{name: "Alice", age: 30}
iex> name
"Alice"
```

---

## Lazy Evaluation with Streams

Streams allow lazy evaluation of enumerable collections:

```elixir
# Eager evaluation
iex> [1, 2, 3] 
     |> Enum.map(&(&1 * 2))
     |> Enum.filter(&(&1 > 2))
[4, 6]

# Lazy evaluation
iex> [1, 2, 3]
     |> Stream.map(&(&1 * 2))
     |> Stream.filter(&(&1 > 2))
     |> Enum.to_list()
[4, 6]
```

Streams are useful for:
- Large or infinite collections
- Composing transformations efficiently

---

## Functions as First-Class Citizens

Functions can be passed as arguments and returned as results:

```elixir
iex> add = fn a, b -> a + b end
iex> add.(1, 2)
3

iex> apply_twice = fn f, x -> f.(f.(x)) end
iex> apply_twice.(fn x -> x * 2 end, 3)
12

# Using the capture operator
iex> multiply_by_two = &(&1 * 2)
iex> multiply_by_two.(5)
10
```

---

## Key Takeaways

- Elixir has scalar (integers, floats, atoms, strings) and composite (lists, tuples, maps, keyword lists) data types
- All data structures are immutable, enabling safe concurrent programming
- Pattern matching is a powerful tool for destructuring and working with data
- Lists are linked structures; tuples are contiguous
- Maps provide key-value storage; keyword lists maintain order
- Streams enable lazy evaluation for efficient data processing
- Functions are first-class citizens and can be composed

---

## Practical Tips

- Use tuples for fixed-size collections and return values
- Use lists for variable-length collections
- Use maps when you need key-value lookups
- Use keyword lists for options and configuration
- Leverage pattern matching to make code more expressive
- Consider streams for large data processing pipelines
