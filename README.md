# AdsGPT agent plugins

The plugins AdsGPT publishes for AI agents such as Claude, Codex and Grok. Each plugin lives in
its own folder under `plugins/`, with a manifest for each client, and this repository is the
marketplace that lists them.

| Plugin                        | What it does                                                                                              |
| ----------------------------- | --------------------------------------------------------------------------------------------------------- |
| [AdsGPT](plugins/adsgpt)      | Create, review and optimize ad campaigns on the ad platforms connected to AdsGPT, such as Google Ads.     |

## Add the marketplace

### Claude Code

```text
/plugin marketplace add adsgpt-dev/agent-plugins
/plugin install adsgpt@adsgpt
```

### Claude (web and desktop)

In **Customize > Plugins**, add the marketplace `adsgpt-dev/agent-plugins` and install a plugin.

### Codex and the ChatGPT desktop app

```bash
codex plugin marketplace add adsgpt-dev/agent-plugins
```

Then open `/plugins` in Codex, or the plugins of the ChatGPT desktop app, and install a plugin
from `adsgpt`.

### Grok

Add the marketplace `adsgpt-dev/agent-plugins` and install a plugin from `adsgpt`.

Each plugin's README says what it runs, sends and reads, and how to sign in.

## Build a plugin for OpenAI

OpenAI's plugin portal takes each plugin as a ZIP. Build it from a committed ref:

```bash
scripts/build-openai-zip.sh            # adsgpt from main
scripts/build-openai-zip.sh adsgpt v1  # another plugin or ref
```

It writes `<plugin>-<version>.zip` in the current directory, with the Codex manifest, the MCP server,
the skills, the assets, the README, the privacy policy and the license.

## License

MIT (`LICENSE`).
