# Additional Guidelines

- Use `jq` to parse JSON results for structured data.
- Use `rg` (ripgrep) to grep quickly within files.
- Use `gh` when asked to read a github related question.
- Do not use `ls -R` in a folder that has a `node_modules` folder. It will be very slow, try to skip `node_modules` folder. You can use `find . -type d -name node_modules -prune -o -print` to list all folders excluding `node_modules`.
- Use `bun` instead of `npm`. And `bun` instead of `vitest` when `vitest` is not used.
- When given an url, use `curl` to get the page content, set `Accept: text/markdown` header to get the page content in markdown format.
- When user gives you a github repo link, if you have to search something in it. Clone it in a temporaty folder and do your research in that folder.
- Keep things simple. A function should have a single purpose and be as short as possible. Do not make huge index or barrel files, split into smaller files if needed to make the code more readable and maintainable.
- When refactoring a function or adding a constant, check if the update can help other functions, and if so update them.


# Important Notes

- Do not think too much, if something isn't clear, ask for clarification. Never assume
- NEVER do too much in one go unless explicitly told to do so.
- NEVER read .env, .envrc, .npmrc or any other sensitive files.
- NEVER remove existing comments, if needed you can adapt them but if the comment is still relevant you have to keep it.

# User informations

- name: Nathan; username: vahor
- use macos or linux ubuntu.
- Developper. So unless specified assume I know how to code, keep things short and simple in messages.
