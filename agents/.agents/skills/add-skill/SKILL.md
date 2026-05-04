---
name: add-skill
description: This skill should be used when the user wants to add a new skill to the agent collection by providing a URL. 
user-invocable: true
---

# Downloading skills

This skill should be used when the user wants to add a new skill to the agent collection by providing a URL. 

The process involves:
1. Acquiring the skill:
   a. If the URL is a direct file link, downloading the `SKILL.md` and any associated reference files.
   b. If the URL is a git repository, cloning it and identifying the skill directory (the one containing `SKILL.md`).
2. Organizing the skill into its own directory within `.agents/skills/`.
3. Updating the `.agents/etc/README.md` (or the main skills README) to include the new source link in the `## Sources` section.

## Skill Format

The `SKILL.md` file should follow the following format:

```md
---
name: {skill-name}
description: {skill-description}
---

{skill-content}
```

## Reference Files

In some cases, when a skill gets more complex, it is beneficial to split in multiple md files. In this case, add a `references/` folder and include the reference files there. Mention the reference files in the `SKILL.md` file as follows:

```md
## References

- [reference-file-name](./references/reference-file-name.md): {when-to-use}
```

## Attribution

When adding a skill, please include the attribution as follows in the main skills README:

```md
## Sources

- [skill-name](repository or URL): {description}
```
