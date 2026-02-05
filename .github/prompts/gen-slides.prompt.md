---
agent: 'agent'
---

## Generate Marp Presentation Slides for Elixir Cookbook Chapter

Create a Marp presentation file for a specific chapter from the "Elixir Cookbook" by Paulo A. Pereira. Source chapters are located in #folder:contents with additional code examples in #folder:src/code.

### Requirements:

**Output Location & Naming:**
- Create the file in the #folder:slides directory
- Use the same filename format as specified in #prompt:gen-files.prompt.md
- Format: `chapter-{number}-{title-with-hyphens}.md`
- Example: For "Chapter 1: Why Elixir? Why Now?" create `chapter-1-why-elixir-why-now.md`

**Input Parameter:**
- Chapter number (required): The chapter number (1-8) to generate slides for

**Chapters Overview:**
1. Command Line - IEx and Mix tools
2. Data Types and Structures - Immutability, pattern matching, lazy evaluation
3. Strings and Binaries - String manipulation in Elixir
4. Modules and Functions - Building blocks, directives, pattern matching
5. Processes and Nodes - Concurrent programming and distribution
6. OTP – Open Telecom Platform - GenServer, supervisors, and OTP constructs
7. Cowboy and Phoenix - Web development, static files, websockets, Phoenix framework
8. Interactions - OS commands, PostgreSQL, Redis, external systems

**Marp Format Requirements:**

1. **Frontmatter** - Include Marp YAML configuration:
   ```markdown
   ---
   marp: true
   theme: default
   class: invert
   paginate: true
   ---
   ```

2. **Slide Structure**:
   - Title slide with chapter number and title
   - Overview/outline slide
   - Content slides organized by topics
   - Summary/key takeaways slide
   - Resources slide (if applicable)

3. **Slide Separators**: Use `---` on separate lines to separate slides

4. **Content Guidelines**:
   - Be brief and concise - use bullet points for complex concepts
   - Focus on practical recipes and their implementation
   - Include code snippets demonstrating techniques (use code blocks with Elixir syntax highlighting)
   - Keep text minimal (max 5-7 bullet points per slide)
   - Use visual hierarchy with clear headings
   - Highlight "Getting ready", "How to do it", and "How it works" sections from recipes
   - Reference actual code examples from #folder:src/code when applicable

5. **Slide Design Tips**:
   - One main topic per slide
   - Use emphasis (`**bold**`, `*italic*`) to highlight key terms
   - Include section divider slides for major topics
   - Use inline code formatting for syntax and concepts

**Output Format Example:**
```markdown
---
marp: true
theme: default
class: invert
paginate: true
---

# Chapter 1: Command Line

*Interactive Elixir and Mix Build Tool*

---

## Chapter Overview

- Using IEx for prototyping
- Loading and compiling modules
- Getting help in IEx
- Creating Mix applications
- Managing dependencies
- Creating custom Mix tasks

---

## Interactive Elixir (IEx)

- **REPL**: Read-Eval-Print-Loop
- Immediate code evaluation
- Test ideas without compilation
- Define modules on the fly
- Access documentation inline

---

### Using IEx - Getting Started

**Start IEx:**
```bash
$ iex
```

**Evaluate expressions:**
```elixir
iex(1)> a = 2 + 2
4
iex(2)> sum = fn(a, b) -> a + b end
iex(3)> sum.(1, 2)
3
```

---

## Mix Build Tool

- Project creation and management
- Dependency handling
- Compilation and testing
- Custom task creation
- Configuration management

---

### Creating a Mix Project

**Simple application:**
```bash
$ mix new my_app
```

**Supervised application:**
```bash
$ mix new my_app --sup
```

**Umbrella application:**
```bash
$ mix new my_app --umbrella
```

---

## Key Takeaways

✓ IEx enables rapid prototyping  
✓ Load modules without restarting  
✓ Mix simplifies project management  
✓ Custom tasks extend functionality  
✓ Built-in documentation access
```
