---
name: create-agentsmd
description: 'Prompt for generating an AGENTS.md file for a repository'
---

# Create high‑quality AGENTS.md file

You are a code agent. Your task is to create a complete, accurate AGENTS.md at the root of this repository.

## What is AGENTS.md?

AGENTS.md is a Markdown file that serves as a "README for agents" - a dedicated, predictable place to provide context and instructions to help AI coding agents work on your project. It complements README.md by containing detailed technical context that coding agents need but might clutter a human-focused README.

## Key Principles

- **Agent-focused**: Contains detailed technical instructions for automated tools
- **Complements README.md**: Doesn't replace human documentation but adds agent-specific context
- **Standardized location**: Placed at repository root (or subproject roots for monorepos)
- **Open format**: Uses standard Markdown with flexible structure
- **Ecosystem compatibility**: Works across 20+ different AI coding tools and agents

## File Structure and Content Guidelines

### 1. Required Setup

- Create the file as `AGENTS.md` in the repository root
- Use standard Markdown formatting
- No required fields - flexible structure based on project needs

### 2. Essential Sections to Include

#### Project Overview

- Brief description of what the project does
- Architecture overview if complex
- Key technologies and frameworks used

#### Setup Commands

- Installation instructions
- Environment setup steps
- Dependency management commands
- Database setup if applicable

#### Development Workflow

- How to start development server
- Build commands
- Watch/hot-reload setup
- Package manager specifics (npm, pnpm, yarn, etc.)

#### Testing Instructions

- How to run tests (unit, integration, e2e)
- Test file locations and naming conventions
- Coverage requirements
- Specific test patterns or frameworks used
- How to run subset of tests or focus on specific areas

#### Code Style Guidelines

- Language-specific conventions
- Linting and formatting rules
- File organization patterns
- Naming conventions
- Import/export patterns

#### Build and Deployment

- Build commands and outputs
- Environment configurations
- Deployment steps and requirements
- CI/CD pipeline information

### 3. Optional but Recommended Sections

#### Security Considerations

- Security testing requirements
- Secrets management
- Authentication patterns
- Permission models

#### Monorepo Instructions (if applicable)

- How to work with multiple packages
- Cross-package dependencies
- Selective building/testing
- Package-specific commands

#### Pull Request Guidelines

- Title format requirements
- Required checks before submission
- Review process
- Commit message conventions

#### Debugging and Troubleshooting

- Common issues and solutions
- Logging patterns
- Debug configuration
- Performance considerations

## Example Template

Use this as a starting template and customize based on the specific project:

```markdown
# AGENTS.md

## Project Overview

[Brief description of the project, its purpose, and key technologies]

## Setup Commands

- Install dependencies: `[package manager] install`
- Start development server: `[command]`
- Build for production: `[command]`

## Development Workflow

- [Development server startup instructions]
- [Hot reload/watch mode information]
- [Environment variable setup]

## Testing Instructions

- Run all tests: `[command]`
- Run unit tests: `[command]`
- Run integration tests: `[command]`
- Test coverage: `[command]`
- [Specific testing patterns or requirements]

## Code Style

- [Language and framework conventions]
- [Linting rules and commands]
- [Formatting requirements]
- [File organization patterns]

## Build and Deployment

- [Build process details]
- [Output directories]
- [Environment-specific builds]
- [Deployment commands]

## Pull Request Guidelines

- Title format: [component] Brief description
- Required checks: `[lint command]`, `[test command]`
- [Review requirements]

## Additional Notes

- [Any project-specific context]
- [Common gotchas or troubleshooting tips]
- [Performance considerations]
```
