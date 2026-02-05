---
chapter: 2
title: Data Types and Structures
total_cards: 22
created_date: 2026-02-04
---

## Elixir Data Types

### Scalar Types
**Q: What are the five scalar data types in Elixir?**  
A: Integers, floating-point numbers, booleans, atoms, and strings.  
Difficulty: Beginner | Tags: data-types, scalars

**Q: What is an atom in Elixir?**  
A: An atom is a constant whose name is its value, prefixed with a colon (e.g., `:hello`).  
Difficulty: Beginner | Tags: atoms, data-types

**Q: How are strings represented in Elixir?**  
A: Strings are binaries (sequences of bytes) enclosed in double quotes, e.g., `"hello"`.  
Difficulty: Beginner | Tags: strings, binaries

**Q: What is the difference between `true` and `:true` in Elixir?**  
A: `true` is the boolean value, while `:true` is an atom. However, in Elixir, booleans ARE atoms (true is :true, false is :false).  
Difficulty: Intermediate | Tags: booleans, atoms

### Composite Types
**Q: What are the four composite data types in Elixir?**  
A: Lists, tuples, maps, and keyword lists.  
Difficulty: Beginner | Tags: data-types, collections

**Q: How are lists denoted in Elixir?**  
A: Lists are denoted by square brackets `[]` and can contain any number of elements.  
Difficulty: Beginner | Tags: lists, syntax

**Q: How are tuples denoted in Elixir?**  
A: Tuples are denoted by curly braces `{}` and can contain any number of elements.  
Difficulty: Beginner | Tags: tuples, syntax

**Q: What syntax is used for maps in Elixir?**  
A: Maps use `%{}` syntax with key-value pairs, e.g., `%{"a" => 1, "b" => 2}`.  
Difficulty: Beginner | Tags: maps, syntax

**Q: What are keyword lists in Elixir?**  
A: Keyword lists are lists of two-element tuples, often used for options: `[{:a, 1}, {:b, 2}]` or `[a: 1, b: 2]`.  
Difficulty: Intermediate | Tags: keyword-lists, collections

## Functional Programming Concepts

### Immutability
**Q: Are variables in Elixir mutable or immutable?**  
A: All data in Elixir is immutable. Operations create new data rather than modifying existing data.  
Difficulty: Beginner | Tags: immutability, functional-programming

**Q: What is the benefit of immutability in concurrent programming?**  
A: Immutability eliminates race conditions and makes concurrent code safer since data cannot be modified by multiple processes.  
Difficulty: Intermediate | Tags: immutability, concurrency

### First-Class Functions
**Q: What does it mean that functions are first-class citizens in Elixir?**  
A: Functions can be passed as arguments to other functions, returned as results, and assigned to variables.  
Difficulty: Intermediate | Tags: functions, functional-programming

**Q: Can you nest lists within lists in Elixir?**  
A: Yes, lists can contain any elements including other lists, e.g., `[[1, 2], [3, 4]]`.  
Difficulty: Beginner | Tags: lists, nesting

## Pattern Matching

**Q: What is pattern matching in Elixir?**  
A: Pattern matching is a way to match data structures against patterns, extracting values or asserting structure.  
Difficulty: Intermediate | Tags: pattern-matching, core-concepts

**Q: How does pattern matching relate to the `=` operator?**  
A: The `=` operator performs pattern matching, binding variables on the left to values on the right.  
Difficulty: Intermediate | Tags: pattern-matching, operators

## Lazy Evaluation

**Q: What is lazy evaluation?**  
A: Lazy evaluation delays computation until the result is actually needed, enabling efficient processing of infinite sequences.  
Difficulty: Intermediate | Tags: lazy-evaluation, streams

**Q: Which Elixir module enables lazy evaluation?**  
A: The Stream module provides lazy evaluation capabilities for working with enumerables.  
Difficulty: Intermediate | Tags: streams, lazy-evaluation

## Working with Collections

**Q: How do you access the first element of a tuple?**  
A: Use pattern matching or the `elem/2` function: `elem(tuple, 0)`.  
Difficulty: Intermediate | Tags: tuples, access

**Q: What's the main difference between tuples and lists in Elixir?**  
A: Tuples are stored contiguously in memory (fast access, slow modification), while lists are linked lists (fast prepending, slower access).  
Difficulty: Advanced | Tags: tuples, lists, performance

**Q: How do you add an element to the beginning of a list?**  
A: Use the cons operator `[new_element | existing_list]` or `List.insert_at/3`.  
Difficulty: Intermediate | Tags: lists, operations

**Q: What advantage do maps have over keyword lists?**  
A: Maps are more efficient for lookups and don't allow duplicate keys, while keyword lists allow duplicates and preserve order.  
Difficulty: Advanced | Tags: maps, keyword-lists, performance

**Q: Can maps have different types of keys?**  
A: Yes, maps can have keys of any type, including atoms, strings, integers, or mixed types.  
Difficulty: Intermediate | Tags: maps, flexibility
