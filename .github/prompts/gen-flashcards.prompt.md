---
agent: 'agent'
---

## Generate Flashcards for Elixir Cookbook Chapter

Create a flashcard/recall presentation file based on a specific chapter from the "Elixir Cookbook" by Paulo A. Pereira. Source chapters are located in #folder:contents with additional code examples in #folder:src/code.

### Requirements:

**Output Location & Naming:**
- Create the file in a #folder:flashcards directory
- Use the same filename format as specified in #prompt:gen-files.prompt.md
- Format: `chapter-{number}-{title-with-hyphens}.md`
- Example: For "Chapter 1: Command Line" create `chapter-1-command-line.md`

**Input Parameter:**
- Chapter number (required): The chapter number (1-8) to generate flashcards for

**Chapters Overview:**
1. Command Line - IEx and Mix tools
2. Data Types and Structures - Immutability, pattern matching, lazy evaluation
3. Strings and Binaries - String manipulation in Elixir
4. Modules and Functions - Building blocks, directives, pattern matching
5. Processes and Nodes - Concurrent programming and distribution
6. OTP – Open Telecom Platform - GenServer, supervisors, and OTP constructs
7. Cowboy and Phoenix - Web development, static files, websockets, Phoenix framework
8. Interactions - OS commands, PostgreSQL, Redis, external systems

**Content Guidelines:**

Extract and organize flashcards from the chapter source file by:

1. **Review Recipe Structure**: Each chapter contains multiple recipes with sections:
   - Getting ready
   - How to do it…
   - How it works…
   - There's more…
   - See also

2. **Create Question-Answer Pairs** from each recipe covering:
   - Core concepts and definitions
   - Step-by-step procedures
   - Code patterns and examples
   - Explanation of behavior and mechanics
   - Practical applications

3. **Format Requirements**: Each flashcard should include:
   - Question (front of card)
   - Answer (back of card)
   - Difficulty level (beginner/intermediate/advanced)
   - Topic/category tag

4. **Cover All Recipe Topics**:
   - Command-line tools (IEx, Mix)
   - Data types and functional concepts
   - Elixir syntax and idioms
   - Concurrent and distributed programming
   - OTP design patterns
   - Web development (Cowboy, Phoenix)
   - External system integrations
   - Code examples from #folder:src/code when relevant

5. **Format Requirements**:
   - Use Markdown with proper heading structure
   - Include YAML front matter with metadata (chapter number, title, total cards, date)
   - Group flashcards by recipe/topic using level 2 headers
   - Use clear, concise language suitable for learning
   - Include code snippets in flashcards when helpful
   - Reference actual code examples from #folder:src/code when applicable

**Output Format Example:**
```markdown
---
chapter: 1
title: Command Line
total_cards: 20
created_date: 2025-02-04
---

## Interactive Elixir (IEx)

### Using IEx REPL
**Q: What is IEx and what does it stand for?**  
A: IEx is Interactive Elixir, a REPL (read-eval-print-loop) environment that allows immediate evaluation of Elixir expressions without compilation.  
Difficulty: Beginner | Tags: iex, repl, command-line

**Q: How do you start an IEx session?**  
A: Type `iex` in your terminal/command line.  
Difficulty: Beginner | Tags: iex, command-line

## Mix Build Tool

### Creating Projects
**Q: What is Mix in the Elixir ecosystem?**  
A: Mix is a build tool that provides tasks to create, compile, and test projects, and handle dependencies.  
Difficulty: Beginner | Tags: mix, build-tool

**Q: How do you create a new supervised Elixir application with Mix?**  
A: Use the command `mix new app_name --sup` to generate a supervised application.  
Difficulty: Intermediate | Tags: mix, supervision, otp
```

```
