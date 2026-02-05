---
marp: true
theme: default
class: invert
paginate: true
---

# Chapter 3: Strings and Binaries

**Elixir Cookbook**
Paulo A. Pereira

---

## Overview

- Understanding strings and binaries in Elixir
- Working with the String module
- String manipulation functions
- Pattern matching with strings
- Binaries and bitstrings
- Practical string processing recipes

---

## Strings in Elixir

Strings in Elixir are UTF-8 encoded binaries:

```elixir
iex> "hello"
"hello"

iex> is_binary("hello")
true

iex> byte_size("hello")
5

iex> String.length("hello")
5

# UTF-8 support
iex> "héllo"
"héllo"
iex> byte_size("héllo")
6  # é takes 2 bytes
iex> String.length("héllo")
5  # but only 5 graphemes
```

---

## String Module Functions

The String module provides comprehensive string manipulation:

```elixir
# Length and case
iex> String.length("hello")
5
iex> String.upcase("hello")
"HELLO"
iex> String.downcase("HELLO")
"hello"
iex> String.capitalize("hello world")
"Hello world"

# Trimming whitespace
iex> String.trim("  hello  ")
"hello"
iex> String.trim_leading("  hello")
"hello"
iex> String.trim_trailing("hello  ")
"hello"
```

---

## Splitting and Joining Strings

Common operations for string manipulation:

```elixir
# Splitting strings
iex> String.split("hello,world,elixir", ",")
["hello", "world", "elixir"]

iex> String.split("hello world", " ", parts: 2)
["hello", "world"]

# Joining strings
iex> Enum.join(["hello", "world"], " ")
"hello world"

# Splitting into graphemes
iex> String.graphemes("hello")
["h", "e", "l", "l", "o"]
```

---

## String Replacement and Pattern Matching

Replacing and searching within strings:

```elixir
# Simple replacement
iex> String.replace("hello world", "world", "Elixir")
"hello Elixir"

# Replace all occurrences
iex> String.replace("hello hello", "hello", "hi")
"hi hi"

# Check if string contains substring
iex> String.contains?("hello world", "world")
true

# Check if string starts/ends with
iex> String.starts_with?("hello", "he")
true
iex> String.ends_with?("hello", "lo")
true
```

---

## String Slicing and Extraction

Extracting parts of strings:

```elixir
# String slicing
iex> String.slice("hello", 0, 2)
"he"

iex> String.slice("hello", 1..3)
"ell"

# Get first/last characters
iex> String.first("hello")
"h"
iex> String.last("hello")
"o"

# Get at index
iex> String.at("hello", 1)
"e"
```

---

## String Interpolation and Concatenation

Building strings dynamically:

```elixir
# String interpolation
iex> name = "Alice"
iex> "Hello, #{name}!"
"Hello, Alice!"

iex> x = 10
iex> "The value is #{x * 2}"
"The value is 20"

# String concatenation
iex> "hello" <> " " <> "world"
"hello world"

iex> "hello" <> " world"
"hello world"
```

---

## Binaries and Bitstrings

Working with raw binary data:

```elixir
# Binary literals
iex> <<1, 2, 3>>
<<1, 2, 3>>

# String to binary
iex> <<104, 101, 108, 108, 111>>
"hello"

# Pattern matching binaries
iex> <<head, tail::binary>> = "hello"
"hello"
iex> head
104  # 'h'
iex> tail
"ello"

# Working with bits
iex> <<a::4, b::4>> = <<123>>
<<123>>
iex> a
7
iex> b
11
```

---

## Practical Recipe: Word Frequency Counter

A practical example of string processing:

```elixir
defmodule WordFrequency do
  def count(text) do
    text
    |> String.downcase()
    |> String.replace(~r/[^\w\s]/, "")
    |> String.split()
    |> Enum.frequencies()
    |> Enum.sort_by(fn {_, count} -> count end, :desc)
  end
end

# Usage
iex> WordFrequency.count("Hello world! Hello Elixir!")
[{"hello", 2}, {"world", 1}, {"elixir", 1}]
```

---

## Regular Expressions

Pattern matching with regex:

```elixir
# Checking for matches
iex> String.match?("hello123", ~r/\d+/)
true

# Extracting matches
iex> Regex.run(~r/\d+/, "hello123")
["123"]

# Scanning for all matches
iex> Regex.scan(~r/\d+/, "abc123def456")
[["123"], ["456"]]

# Named captures
iex> Regex.named_captures(~r/(?<word>\w+)/, "hello")
%{"word" => "hello"}
```

---

## String to Atom Conversion (Carefully!)

Converting between strings and atoms:

```elixir
# String to atom
iex> String.to_atom("hello")
:hello

# Atom to string
iex> Atom.to_string(:hello)
"hello"

# Safe conversion (existing atoms only)
iex> String.to_existing_atom("hello")
** (ArgumentError) argument error

# Create the atom first
iex> :hello
:hello
iex> String.to_existing_atom("hello")
:hello
```

⚠️ **Warning**: Atoms are not garbage collected. Never convert user input directly to atoms!

---

## Practical Recipe: Parsing MP3 Info

Reading binary data from files:

```elixir
defmodule MP3Info do
  def parse(file_path) do
    file_path
    |> File.read!()
    |> extract_id3_tag()
  end

  defp extract_id3_tag(<<
    "TAG",
    title::binary-size(30),
    artist::binary-size(30),
    _rest::binary
  >>) do
    %{
      title: String.trim(title),
      artist: String.trim(artist)
    }
  end
end
```

---

## Pipeline Transformation Recipe

Using pipes for string transformations:

```elixir
defmodule PipeTransformation do
  def transform(input) do
    input
    |> String.trim()
    |> String.downcase()
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(&(&1 == ""))
    |> Enum.join("\n")
  end
end

# Clean and normalize multi-line text
iex> PipeTransformation.transform("  Hello  \n\n  World  \n")
"hello\nworld"
```

---

## Key Takeaways

- Strings in Elixir are UTF-8 encoded binaries
- The String module provides rich functionality for manipulation
- Pattern matching works with strings and binaries
- String interpolation uses `#{expression}` syntax
- Binaries allow working with raw byte data
- Regular expressions are powerful for pattern matching
- Be cautious when converting strings to atoms
- Pipeline operator (`|>`) makes transformations readable

---

## Best Practices

- Use String functions for text manipulation
- Prefer `String.length/1` over `byte_size/1` for grapheme count
- Use binary pattern matching for efficient parsing
- Leverage regular expressions for complex patterns
- Always handle UTF-8 encoding properly
- Use streams for large text files
- Avoid creating atoms from user input
