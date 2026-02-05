---
chapter: 1
title: Command Line
total_cards: 20
created_date: 2026-02-04
---

## Interactive Elixir (IEx)

### Using IEx REPL
**Q: What is IEx and what does it stand for?**  
A: IEx is Interactive Elixir, a REPL (read-eval-print-loop) environment that allows immediate evaluation of Elixir expressions without compilation.  
Difficulty: Beginner | Tags: iex, repl, command-line

**Q: How do you start an IEx session?**  
A: Type `iex` in your terminal/command line.  
Difficulty: Beginner | Tags: iex, command-line

**Q: How do you quit from IEx?**  
A: Press Ctrl + C twice.  
Difficulty: Beginner | Tags: iex, command-line

**Q: What does the = operator do in Elixir?**  
A: The = operator is a pattern matching operator, not an assignment operator. It matches the right side to the left side.  
Difficulty: Beginner | Tags: pattern-matching, operators

**Q: How do you define an anonymous function in IEx?**  
A: Use the fn keyword: `sum = fn(a, b) -> a + b end`  
Difficulty: Beginner | Tags: functions, anonymous-functions

**Q: How do you call an anonymous function in Elixir?**  
A: Use dot notation: `sum.(1, 2)` - note the dot before the parentheses.  
Difficulty: Beginner | Tags: functions, anonymous-functions

**Q: Can you define modules directly in IEx without saving to a file?**  
A: Yes, IEx allows you to define entire modules interactively without compiling a source file.  
Difficulty: Beginner | Tags: iex, modules

## Mix Build Tool

### Creating Projects
**Q: What is Mix in the Elixir ecosystem?**  
A: Mix is a build tool that provides tasks to create, compile, and test projects, and handle dependencies.  
Difficulty: Beginner | Tags: mix, build-tool

**Q: How do you create a new simple Elixir application with Mix?**  
A: Use the command `mix new app_name` to generate a simple application.  
Difficulty: Beginner | Tags: mix, project-creation

**Q: How do you create a new supervised Elixir application with Mix?**  
A: Use the command `mix new app_name --sup` to generate a supervised application.  
Difficulty: Intermediate | Tags: mix, supervision, otp

**Q: What flag is used to create an umbrella application with Mix?**  
A: Use the `--umbrella` flag: `mix new app_name --umbrella`  
Difficulty: Intermediate | Tags: mix, umbrella, project-structure

**Q: What is the purpose of the mix.exs file?**  
A: The mix.exs file defines the project configuration, dependencies, and application structure for a Mix project.  
Difficulty: Intermediate | Tags: mix, configuration

### Mix Tasks
**Q: Can you create custom Mix tasks?**  
A: Yes, Mix supports custom task creation to extend its functionality with project-specific workflows.  
Difficulty: Intermediate | Tags: mix, custom-tasks

**Q: What command shows available Mix tasks?**  
A: Use `mix help` to see all available Mix tasks.  
Difficulty: Beginner | Tags: mix, help

## Loading and Compiling

### Module Management
**Q: How can you load a module from a file into IEx?**  
A: Use the `c("filename.ex")` function in IEx to compile and load a module.  
Difficulty: Intermediate | Tags: iex, modules, compilation

**Q: Why is IEx useful for prototyping?**  
A: IEx allows instant feedback without the overhead of editing source files and compiling them, encouraging experimentation.  
Difficulty: Beginner | Tags: iex, prototyping, workflow

**Q: What makes Mix different from just using Elixir directly?**  
A: Mix provides project structure, dependency management, compilation tasks, testing frameworks, and organized workflows that Elixir alone doesn't provide.  
Difficulty: Intermediate | Tags: mix, project-management

### Dependencies
**Q: How do you manage dependencies in a Mix project?**  
A: Dependencies are defined in the `deps` function in mix.exs, then fetched using `mix deps.get`.  
Difficulty: Intermediate | Tags: mix, dependencies

**Q: Which framework mentioned in the book defines its own custom Mix tasks?**  
A: Phoenix framework defines many custom Mix tasks for web development workflows.  
Difficulty: Intermediate | Tags: mix, phoenix, custom-tasks

**Q: What is the REPL pattern that IEx implements?**  
A: Read-Eval-Print-Loop: takes user expressions, evaluates them, returns the result, and repeats.  
Difficulty: Beginner | Tags: iex, repl, patterns
