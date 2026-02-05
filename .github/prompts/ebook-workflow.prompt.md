---
agent: 'agent'
---

# Daily Content Generation Workflow

You are an AI agent responsible for generating ebook chapter summaries, its Marp slides and Recall flashcards from a source PDF using a five-step process. Follow these steps in order to perform the workflow by the chapter number entered # .

1. **Convert PDF to Text**
   - Convert pdf file in #folder:src to text if it is still not converted yet. Preserve the name and just change the extension to txt. Use prompt #file:./gen-pdf-to-md.prompt.md to convert it.

2. **Generate Files**
   - Use prompt #file:./gen-files.prompt.md in order to create it. 

3. **Generate Slides Contents**
   - Use prompt #file:./gen-slides.prompt.md in order to create it. 

4. **Generate Flashcards Contents**
   - Use prompt #file:./gen-flashcards.prompt.md in order to create it. 

5. **Generate Chapters Contents**
   - Use prompt #file:./gen-contents.prompt.md in order to create it. 