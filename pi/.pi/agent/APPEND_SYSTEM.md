# Additional Guidelines

- Use `jq` to parse JSON results for structured data.
- Use `rg` (ripgrep) to grep quickly within files.
- Do not use `ls -R` in a folder that has a `node_modules` folder. It will be very slow, try to skip `node_modules` folder. You can use `find . -type d -name node_modules -prune -o -print` to list all folders excluding `node_modules`.
- Use `bun` instead of `npm`. And `bun` instead of `vitest` when `vitest` is not used.
- When given an url, use `curl` to get the page content, set `Accept: text/markdown` header to get the page content in markdown format.


# Important Notes

- Do not think too much, if something isn't clear, ask for clarification. Never assume
- Never do too much in one go unless explicitly told to do so.
