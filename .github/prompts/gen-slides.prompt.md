---
agent: 'agent'
---
Generate a Marp presentation file in #folder:slides with the same name rules as specified in #prompt:gen-files.prompt.md for the content of the chapter # specified from the ebook located in #folder:src .
Be brief and concise in the slides content, use bullet points when possible, code snippets when needed, and include relevant diagrams in Mermaid format where applicable use Visual Standards and Mermaid Theme Configuration below.

**Visual Standards:**
- Use pastel color themes compatible with both dark and light browser themes
- Include relevant emojis for visual engagement and clarity
- Organize complex diagrams using subgraphs for better readability
- Size diagrams to fit A4 paper when printed (max width: 180mm)
- Use consistent color coding across all diagrams

**Mermaid Theme Configuration:**

Use this theme init block at the start of every Mermaid diagram:

```
%%{init: {
  'theme':'base',
  'themeVariables': {
    'primaryColor':'#E8F4FD',
    'primaryBorderColor':'#4A90E2',
    'primaryTextColor':'#2C3E50',
    'secondaryColor':'#F0F8E8',
    'tertiaryColor':'#FDF2E8',
    'quaternaryColor':'#F8E8F8',
    'lineColor':'#5D6D7E',
    'fontFamily':'Inter,Segoe UI,Arial'
  }
}}%%
graph TB
  %% Your diagram content here
```
