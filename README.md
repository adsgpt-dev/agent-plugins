# AdsGPT for AI clients

Create, review and optimize ad campaigns from your AI client on the ad platforms your organization
connected to [AdsGPT](https://adsgpt.vercel.app), such as Google Ads. This package adds two things
to Claude, Codex and Grok:

- **The AdsGPT MCP server**, which reads and changes your ad accounts with your AdsGPT account.
- **The AdsGPT skills**, the instructions that guide the model through each task: how to create a
  campaign as a plan you approve once, how to write ads within each format's limits, how to review
  and optimize spend, and the rules of each platform and campaign type.

The MCP server works without the skills; the skills make the model ask the right questions and get
each campaign right at the first attempt.

You need an AdsGPT account with an ad account connected. A new campaign launches paused, and the
client asks for your approval before every tool that changes something.

## Install

### Claude Code

```text
/plugin marketplace add adsgpt-dev/agent-plugins
/plugin install adsgpt@adsgpt-mcp
```

Then run `/mcp`, choose `plugin:adsgpt:adsgpt` and sign in with your AdsGPT account.

### Claude (web and desktop)

In **Customize > Plugins**, add the marketplace `adsgpt-dev/agent-plugins` and install **AdsGPT**. Then
connect the AdsGPT server from the plugin's **Connectors** tab and sign in.

### Codex and the ChatGPT desktop app

```bash
codex plugin marketplace add adsgpt-dev/agent-plugins
```

Then open `/plugins` in Codex, or the plugins of the ChatGPT desktop app, install **AdsGPT** from
`adsgpt-mcp` and start a new session. Sign in with your AdsGPT account when the client
asks.

### Grok

Add the marketplace `adsgpt-dev/agent-plugins` and install `adsgpt` from `adsgpt-mcp`. Grok
signs in with your AdsGPT account on first use.

## What it runs, sends and reads

- **On your machine, nothing.** The package has no scripts, hooks, commands or binaries: only the
  skills, which are Markdown the model reads, the manifest of each client and the address of the
  MCP server. The skills bring no instructions from anywhere else.
- **One remote server,** `https://mcp.adsgpt.dev`, over HTTPS (`.mcp.json`). Your client
  signs in with OAuth 2.1 and keeps the token; it asks for `ads:read` and, the first time a tool
  changes something, for `ads:write`.
- **What reaches the server:** the calls your client's model makes to its tools, with their inputs,
  such as an account id, a GAQL query, a campaign plan, ad texts, image URLs, YouTube links or a
  landing page URL. Never your conversation.
- **What the server does with them:** it reads and changes the ad accounts your organization
  connected to AdsGPT, through each platform's API, and keeps the plans, ads and a log of every
  change in your AdsGPT organization. It reads the landing page of a campaign once per site to
  learn the brand, downloads the images you give by URL to check them, and uploads to the ad
  account the images a plan needs when you save it.

The privacy policy (`PRIVACY.md`) says what AdsGPT stores and shares.

### Tools

| Tool                       | What it does                                                           | Changes something |
| -------------------------- | ---------------------------------------------------------------------- | ----------------- |
| `list_accounts`            | Lists the connected ad accounts and the platforms you can connect.     | No                |
| `resolve_destination_url`  | Reads the brand of a campaign's landing page.                          | Saves the brand   |
| `save_blueprint`           | Saves a campaign plan and checks it with each platform.                | Yes               |
| `save_creatives`           | Saves the ad texts of a plan.                                          | Yes               |
| `save_image_creatives`     | Adds images to the ads of a plan, by URL.                              | Yes               |
| `save_video_creatives`     | Adds YouTube videos to the ads of a plan, by link.                     | Yes               |
| `launch_blueprint`         | Launches a plan on every platform, paused unless you ask otherwise.    | Yes               |
| `google_ads_report`        | Reports the performance of an account, its campaigns, ads or keywords. | No                |
| `google_ads_search`        | Queries an account with GAQL.                                          | No                |
| `google_ads_fields`        | Looks up GAQL fields.                                                  | No                |
| `google_ads_docs`          | Reads the Google Ads API reference.                                    | No                |
| `google_ads_list_assets`   | Lists the images and videos of an account.                             | No                |
| `google_ads_validate`      | Checks changes without applying them.                                  | No                |
| `google_ads_upload_images` | Uploads images to an account's library.                                | Yes               |
| `google_ads_update_budget` | Changes a campaign's budget.                                           | Yes               |
| `google_ads_update_status` | Pauses or enables campaigns, ad groups or ads.                         | Yes               |
| `google_ads_mutate`        | Makes any other change in an account.                                  | Yes               |

The `google_ads_*` tools appear only when your organization connected Google Ads.

## Skills

| Skill                    | What it covers                                                       |
| ------------------------ | -------------------------------------------------------------------- |
| `adsgpt-agent`           | The rules of any request about your ad accounts.                     |
| `adsgpt-create-campaign` | Creating a campaign as a plan, from the objective to the launch.     |
| `adsgpt-google-ads`      | Google Ads: its tools, queries, objectives and campaign types.       |
| `adsgpt-write-ads`       | Writing ad copy from the brand's facts, within each format's limits. |
| `adsgpt-optimize`        | Reviewing performance and improving spend.                           |

## About this repository

AdsGPT publishes this package from its own repository: the skills here are a copy, replaced on
each release. Report problems in this repository's issues.

## License

MIT (`LICENSE`).
