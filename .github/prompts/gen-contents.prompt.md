---
agent: 'agent'
---
Generate the content for chapter # specified of the ebook located in the  #folder:src according to the following rules and actions below, keep the content in this order with the titles:

**Summary**

Do: Summarize up the content of the chapter # specified.

**Concepts Map**

Do: Create a Mermaid diagram in text format of the Chapter content, identifying key concepts, keep their names short, breaking down these concepts and their interrelations from the given text of the Chapter. Enhance it with named relationships and make use of subgraphs when possible.
Use pastel color themes compatible with both dark and light browser themes. 
Use consistent color coding across all diagrams. 
Include relevant emojis for visual engagement and clarity. 
Use the following configuration for the Mermaid diagrams:
**Mermaid Theme Configuration:**
```mermaid
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
```

**Key Concepts**

Do: Generate a list of key concepts and their meanings for Chapter. Use bullets with * for put the name of the concept in bold e.g.:
* **concept** concept description

**Quiz**

Do: Generate exactly ten multiple choice questions picking up the content of the chapter specified of the ebook in #folder:src. Ensure there are exactly ten questions, no more and no less. Append next to the title a timestamp as YYYYMMDD_HH:MM:SS. For the choice questions options use a lowercase letter to identify each choice but prefixed with a checkbox in the format `- [ ]` and do not prefix it with tab see below a example:
1. What is the primary focus of software design and architecture?
- a) Writing code quickly
- b) Achieving maintainable and scalable software
- c) Using the latest programming language
- d) Avoiding documentation
The correct answers with brief explanations shall be appended at the end of the Quiz.

**Challenge**

Generate a Challenge up of the content of the chapter specified of the ebook in #folder:src. The Challenge answer with brief explanations shall be appended at the end of the Challenge.
