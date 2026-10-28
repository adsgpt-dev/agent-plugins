# AdsGPT agent plugins

The plugins AdsGPT publishes for AI agents such as Claude, Codex and Grok. Each plugin lives in
its own folder under `plugins/`, with a manifest for each client, and this repository is the
marketplace that lists them.

| Plugin                        | What it does                                                                                              |
| ----------------------------- | --------------------------------------------------------------------------------------------------------- |
| [AdsGPT](plugins/adsgpt)      | Create, review and optimize ad campaigns on the ad platforms connected to AdsGPT, such as Google Ads and Wortise Ads. |

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

### Cursor

Install a plugin from the Cursor Marketplace, once it's listed there. Each plugin also has a
`.cursor-plugin/plugin.json` manifest, and this repository a `.cursor-plugin/marketplace.json`.

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

## MCP Registry

`registry/<plugin>/server.json` describes each plugin's MCP server for the official
[MCP Registry](https://registry.modelcontextprotocol.io), where clients discover it. AdsGPT is
`dev.adsgpt/adsgpt`: the registry verifies the `dev.adsgpt` namespace with a TXT record on
`adsgpt.dev` and the Ed25519 key that signs it. To publish a new version, raise `version` and run:

```bash
cd registry/adsgpt
mcp-publisher login dns --domain adsgpt.dev \
  --private-key "$(openssl pkey -in ~/.config/mcp-registry/adsgpt.dev.pem -outform DER | tail -c 32 | xxd -p -c 64)"
mcp-publisher publish
```

## License

MIT (`LICENSE`).
