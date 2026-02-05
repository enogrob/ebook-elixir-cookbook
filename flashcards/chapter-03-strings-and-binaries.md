---
chapter: 3
title: Strings and Binaries
total_cards: 18
created_date: 2026-02-04
---

## String Basics

**Q: What are strings in Elixir?**  
A: Strings in Elixir are binaries - sequences of bytes encoded in UTF-8.  
Difficulty: Beginner | Tags: strings, binaries

**Q: What module provides functions for working with strings?**  
A: The `String` module contains functions for manipulating strings.  
Difficulty: Beginner | Tags: string-module, standard-library

**Q: How do you get the length of a string in Elixir?**  
A: Use `String.length/1`, which returns the number of graphemes (Unicode characters).  
Difficulty: Beginner | Tags: string-functions, length

**Q: What's the difference between `String.length/1` and `byte_size/1`?**  
A: `String.length/1` counts graphemes (characters), while `byte_size/1` counts bytes. For UTF-8, these may differ.  
Difficulty: Intermediate | Tags: strings, unicode, bytes

## String Operations

**Q: How do you convert a string to uppercase?**  
A: Use `String.upcase/1`: `String.upcase("hello")` returns `"HELLO"`.  
Difficulty: Beginner | Tags: string-functions, case-conversion

**Q: How do you convert a string to lowercase?**  
A: Use `String.downcase/1`: `String.downcase("HELLO")` returns `"hello"`.  
Difficulty: Beginner | Tags: string-functions, case-conversion

**Q: How do you remove leading and trailing whitespace from a string?**  
A: Use `String.trim/1`: `String.trim("  hello  ")` returns `"hello"`.  
Difficulty: Beginner | Tags: string-functions, trimming

**Q: How do you split a string into substrings?**  
A: Use `String.split/2`: `String.split("hello,world", ",")` returns `["hello", "world"]`.  
Difficulty: Beginner | Tags: string-functions, splitting

**Q: How do you replace a substring within a string?**  
A: Use `String.replace/3`: `String.replace("hello world", "world", "Elixir")` returns `"hello Elixir"`.  
Difficulty: Beginner | Tags: string-functions, replacement

## Binaries

**Q: What is a binary in Elixir?**  
A: A binary is a sequence of bytes. Strings are a specific type of binary that contains valid UTF-8 encoded text.  
Difficulty: Intermediate | Tags: binaries, data-types

**Q: How do you check if a value is a binary?**  
A: Use the `is_binary/1` function or pattern match with `<<>>`syntax.  
Difficulty: Intermediate | Tags: binaries, guards

**Q: What is the binary concatenation operator?**  
A: The `<>` operator concatenates binaries: `"hello" <> " world"` returns `"hello world"`.  
Difficulty: Beginner | Tags: operators, concatenation

## String Interpolation

**Q: How do you interpolate variables in strings?**  
A: Use `#{}` syntax: `"Hello #{name}!"` where name is a variable.  
Difficulty: Beginner | Tags: interpolation, syntax

**Q: Can you use expressions inside string interpolation?**  
A: Yes, you can use any Elixir expression: `"Sum: #{1 + 2}"` returns `"Sum: 3"`.  
Difficulty: Beginner | Tags: interpolation, expressions

## Character Lists vs Strings

**Q: What is a character list (charlist) in Elixir?**  
A: A charlist is a list of integers representing Unicode code points, denoted with single quotes: `'hello'`.  
Difficulty: Intermediate | Tags: charlists, data-types

**Q: What's the difference between `"hello"` and `'hello'`?**  
A: `"hello"` is a string (binary), while `'hello'` is a charlist (list of integers).  
Difficulty: Intermediate | Tags: strings, charlists, syntax

## String Patterns

**Q: Does Elixir support regular expressions?**  
A: Yes, Elixir has the `Regex` module for working with regular expressions.  
Difficulty: Intermediate | Tags: regex, patterns

**Q: How do you check if a string contains a substring?**  
A: Use `String.contains?/2`: `String.contains?("hello world", "world")` returns `true`.  
Difficulty: Beginner | Tags: string-functions, searching
