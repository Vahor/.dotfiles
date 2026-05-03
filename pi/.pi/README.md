# Pi Configuration

This directory contains configurations for the pi agent and related tools.

## AI Tools & Packages

- https://pi.dev/packages/pi-mcp-adapter
- https://pi.dev/packages/@samfp/pi-memory
- https://github.com/nicobailon/pi-powerline-footer

### Adding Skills
```bash
bunx skills@latest add mattpocock/skills
# Usage: grillme; grill-with-docs 
```

## Model Configuration

```json: .pi/agent/models.json
{
  "providers": {
    "lmstudio": {
      "baseUrl": "http://localhost:1234/v1",
      "api": "openai-completions",
      "apiKey": "lm-to",
      "models": [
        {
          "id": "google/gemma-4-26b-a4b",
          "input": ["text", "image"]
        }
      ]
    }
  }
}
```
