---
chapter: 7
title: Cowboy and Phoenix
total_cards: 18
created_date: 2026-02-04
---

## Cowboy Basics

**Q: What is Cowboy?**  
A: Cowboy is a small, fast, and modular HTTP server for Erlang/Elixir.  
Difficulty: Beginner | Tags: cowboy, http-server

**Q: What are the main characteristics of Cowboy?**  
A: Small, fast, modular, and designed for Erlang/Elixir applications.  
Difficulty: Beginner | Tags: cowboy, features

**Q: How do you add Cowboy as a dependency?**  
A: Add `{:cowboy, "~> 2.0"}` to the deps list in mix.exs.  
Difficulty: Beginner | Tags: cowboy, dependencies

**Q: What function starts a Cowboy server?**  
A: `:cowboy.start_clear/2` starts an HTTP server (non-SSL).  
Difficulty: Intermediate | Tags: cowboy, initialization

**Q: What do you need to define for Cowboy routing?**  
A: A dispatch configuration using `:cowboy_router.compile/1` that maps paths to handler modules.  
Difficulty: Intermediate | Tags: cowboy, routing

## Phoenix Framework

**Q: What is Phoenix?**  
A: Phoenix is a web development framework for Elixir that provides a productive environment for building web applications.  
Difficulty: Beginner | Tags: phoenix, frameworks

**Q: How do you create a new Phoenix project?**  
A: Use the Mix task: `mix phx.new project_name`.  
Difficulty: Beginner | Tags: phoenix, project-creation

**Q: What are the main components of a Phoenix application?**  
A: Router, controllers, views, templates, channels, and contexts.  
Difficulty: Intermediate | Tags: phoenix, architecture

**Q: Where do you find the official Phoenix installation guide?**  
A: At hexdocs.pm/phoenix/installation.html  
Difficulty: Beginner | Tags: phoenix, documentation

## Web Development Concepts

**Q: What can you serve with Cowboy?**  
A: Static files, dynamic content, WebSockets, and APIs.  
Difficulty: Intermediate | Tags: cowboy, capabilities

**Q: Does Phoenix support WebSockets?**  
A: Yes, Phoenix has excellent WebSocket support through Phoenix Channels.  
Difficulty: Intermediate | Tags: phoenix, websockets

**Q: What is Phoenix Channels?**  
A: A Phoenix feature for real-time, bi-directional communication using WebSockets or long-polling.  
Difficulty: Intermediate | Tags: phoenix, channels, real-time

**Q: Can Phoenix serve static files?**  
A: Yes, Phoenix can serve static assets like CSS, JavaScript, and images.  
Difficulty: Beginner | Tags: phoenix, static-files

## Phoenix Features

**Q: What makes Phoenix suitable for web applications?**  
A: High performance, real-time capabilities, productive development environment, and fault tolerance.  
Difficulty: Intermediate | Tags: phoenix, advantages

**Q: Does Phoenix follow MVC pattern?**  
A: Yes, Phoenix follows a Model-View-Controller-like pattern with router, controllers, views, and templates.  
Difficulty: Intermediate | Tags: phoenix, patterns

**Q: What is the Phoenix router?**  
A: The router maps HTTP requests to controller actions based on the URL path and HTTP method.  
Difficulty: Intermediate | Tags: phoenix, routing

**Q: Can you use Phoenix for APIs?**  
A: Yes, Phoenix is excellent for building JSON APIs alongside or instead of HTML applications.  
Difficulty: Intermediate | Tags: phoenix, api

**Q: What database library does Phoenix typically use?**  
A: Ecto, the database wrapper and query generator for Elixir.  
Difficulty: Intermediate | Tags: phoenix, ecto, databases
