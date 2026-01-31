---
agent: 'agent'
---

Convert every PDF file in #folder:src to Markdown.

File search guidance for agents:
- When searching for PDF files, always use a pattern that matches files with spaces and special characters, e.g. `ls -l src/*.pdf`.
- Ensure your file search logic or script is robust to handle filenames with spaces or special characters (e.g. quoting patterns, not splitting on spaces).
- If using a shell or script, always quote the pattern: "src/*.pdf" or use: find src -name "*.pdf"
- Always run the search from the project root unless otherwise specified.


Requirements:
1. Preserve the original base filename; only change extension to `.md`.
2. Use MCP server `markitdown` for the initial extraction.
3. Perform a cleanup pass AFTER extraction with these rules:
	- Remove stray form-feed characters (\f) and blank list placeholders like isolated `1.` / `2.` / `3.` lines with no text following.
	- Merge list number lines that were split across lines so ordered lists appear as `1. Item text` (no empty lines between the number and the text).
	- Convert PDF bullet artifacts (`•`, `◦`, `-` used alone on a line) into proper Markdown bullets `*` with a single space.
	- Normalize headings: detect lines that are ALL CAPS or Title Case that stand alone and upgrade them to Markdown headings with appropriate levels (e.g. top title => `##`, section => `###`). Avoid duplicating heading markers if already present.
	- Remove duplicate consecutive blank lines (collapse to at most one).
	- Join broken URLs that were split by hyphen + newline (e.g. `ﬂex` ligature or `-
	 -4p-automatico`). Produce a single continuous URL.
	- Replace common PDF ligatures and artifacts: `ﬁ` -> `fi`, `ﬂ` -> `fl`, ensure accent characters remain correct (UTF-8 preserved).
	- Ensure there is a blank line before and after each heading and list block for proper Markdown rendering.
	- Preserve meaningful emphasis or quotes; do NOT wrap arbitrary words in asterisks.
4. Fix the specific Webmotors URL from the PDF to the readable version without stray hyphens or broken lines.
5. Where an ordered list was clearly intended (numbered sequence with increasing integers), keep the numbering explicit (do NOT collapse to all `1.` style).
6. Do NOT add unsolicited commentary or new sections—only structure and normalize the existing content.

Output quality checklist (must be true before writing file):
- No stray bullets (`•`) remain.
- No isolated list numbers without content.
- No form-feed characters.
- No broken (wrapped) URLs.
- Headings rendered with `##` / `###` etc. consistently.

If multiple PDFs exist, repeat the process for each.

If no PDF files are found, double-check your file search logic and working directory. Ensure that files with spaces or special characters in their names are not skipped.