---
chapter: 4
title: Modules and Functions
total_cards: 24
created_date: 2026-02-04
---

## Module Basics

**Q: What are modules in Elixir?**  
A: Modules are containers that group related functions, constants, and attributes, organizing code in a logical way.  
Difficulty: Beginner | Tags: modules, organization

**Q: How do you define a module in Elixir?**  
A: Use the `defmodule` keyword: `defmodule MyModule do ... end`.  
Difficulty: Beginner | Tags: modules, syntax

**Q: Can modules be namespaced in Elixir?**  
A: Yes, use dot notation: `defmodule MyApp.Math.Addition do ... end`.  
Difficulty: Beginner | Tags: modules, namespacing

## Module Attributes

**Q: What are module attributes in Elixir?**  
A: Module attributes are values prefixed with `@` that can store constants and metadata within modules.  
Difficulty: Intermediate | Tags: attributes, constants

**Q: How do you define a constant using module attributes?**  
A: Define an attribute with `@`: `@pi 3.14159`, then reference it in functions.  
Difficulty: Intermediate | Tags: attributes, constants

**Q: What is `@moduledoc` used for?**  
A: `@moduledoc` provides documentation for the entire module.  
Difficulty: Beginner | Tags: documentation, attributes

**Q: What is `@doc` used for?**  
A: `@doc` provides documentation for individual functions.  
Difficulty: Beginner | Tags: documentation, attributes

## Functions

**Q: How do you define a public function in a module?**  
A: Use the `def` keyword: `def function_name(args), do: body`.  
Difficulty: Beginner | Tags: functions, public

**Q: How do you define a private function in a module?**  
A: Use the `defp` keyword: `defp private_function(args), do: body`.  
Difficulty: Beginner | Tags: functions, private

**Q: What syntax is used for defining default arguments?**  
A: Use the `\\` operator: `def greet(name \\ "world"), do: "Hello, #{name}!"`.  
Difficulty: Intermediate | Tags: functions, default-arguments

## Module Directives

**Q: What does the `import` directive do?**  
A: `import` brings functions and macros from another module so they can be called without the module prefix.  
Difficulty: Intermediate | Tags: directives, import

**Q: What does the `alias` directive do?**  
A: `alias` creates a shortcut for a module name: `alias MyApp.LongModuleName, as: LM`.  
Difficulty: Intermediate | Tags: directives, alias

**Q: What does the `require` directive do?**  
A: `require` ensures a module is compiled and available, often needed for macros.  
Difficulty: Intermediate | Tags: directives, require

**Q: What does the `use` directive do?**  
A: `use` invokes a module's `__using__` macro, often for bringing in behaviors or functionality.  
Difficulty: Advanced | Tags: directives, use, macros

## Pattern Matching in Functions

**Q: Can functions have multiple clauses with different patterns?**  
A: Yes, you can define multiple function clauses that pattern match on arguments.  
Difficulty: Intermediate | Tags: pattern-matching, functions

**Q: What are guard clauses in function definitions?**  
A: Guards are conditions specified with `when` that must be true for a function clause to match.  
Difficulty: Intermediate | Tags: guards, functions

**Q: How do you use guards in a function definition?**  
A: Add `when` after parameters: `def even?(n) when is_integer(n) and rem(n, 2) == 0, do: true`.  
Difficulty: Intermediate | Tags: guards, syntax

## Behaviors

**Q: What are behaviors in Elixir?**  
A: Behaviors are similar to interfaces - they define a set of functions that a module must implement.  
Difficulty: Intermediate | Tags: behaviors, contracts

**Q: How do you define a behavior?**  
A: Use `@callback` to specify required functions: `@callback run(any) :: any`.  
Difficulty: Advanced | Tags: behaviors, callbacks

**Q: How do you implement a behavior in a module?**  
A: Use `@behaviour` attribute: `@behaviour MyApp.Behavior`.  
Difficulty: Advanced | Tags: behaviors, implementation

## Documentation

**Q: How can you view documentation in IEx?**  
A: Use the `h` helper: `h String.split` shows documentation for that function.  
Difficulty: Beginner | Tags: documentation, iex

**Q: Why is documenting modules and functions important?**  
A: Documentation makes code maintainable, helps other developers understand functionality, and can be viewed in IEx or generated as HTML.  
Difficulty: Beginner | Tags: documentation, best-practices

## Scripted Mode

**Q: Can you use modules in Elixir scripts?**  
A: Yes, modules can be defined and used in .exs script files or loaded in IEx with `c("file.ex")`.  
Difficulty: Intermediate | Tags: scripts, modules

**Q: What's the difference between .ex and .exs files?**  
A: .ex files are meant to be compiled, while .exs files are scripts that are interpreted.  
Difficulty: Intermediate | Tags: files, scripts
