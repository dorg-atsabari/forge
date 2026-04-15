# forge

A Claude Code plugin marketplace — a workshop for plugins that shape how you build software with Claude Code.

## Install the marketplace

```
/plugin marketplace add https://github.com/dorg-atsabari/forge
```

## Plugins

| Plugin | Description |
|---|---|
| [`spec-driven-dev`](./spec-driven-dev) | Full product-dev pipeline — use cases, tech design, UX/UI design, dev plans, pre-commit, commit, document |

## Install a plugin

```
/plugin install <plugin-name>@forge
```

Example:

```
/plugin install spec-driven-dev@forge
```

## Contributing

To add a new plugin to this marketplace:

1. Create a new folder at the repo root (e.g., `my-plugin/`)
2. Add a `.claude-plugin/plugin.json` inside it
3. Add an entry to `.claude-plugin/marketplace.json` with `"source": "./my-plugin"`

## License

MIT — see [LICENSE](./LICENSE)
