# Skills

This directory contains custom skills for agents used in this project.

When stowed, these skills will be available at `.agents/skills/`.

External Pi skills installed with the `skills` CLI are listed in `../../external-skills` and installed with `../../install-external-skills` into `~/.pi/agent/skills/external/`.

Each skill should be organized in its own subdirectory, following the structure:
- `.agents/skills/<skill-name>/SKILL.md` (Description of the skill)
- `.agents/skills/<skill-name>/tools/` (Optional: implementation details or scripts)

## Sources
- [effect-ts](https://raw.githubusercontent.com/martinffx/atelier/refs/heads/main/skills/typescript-effect-ts/SKILL.md)
- [git-worktree](https://raw.githubusercontent.com/martinffx/atelier/refs/heads/main/skills/code-git-worktrees/SKILL.md)
- [postgres/pg_column_tetris](https://github.com/rogerwelin/pg_column_tetris): PostgreSQL column-ordering guidance for reducing row padding and table size.
- [web-search](https://github.com/tavily-ai/skills/blob/main/skills/tavily-cli/SKILL.md)
- minimal-solution. Based off https://github.com/DietrichGebert/ponytail
