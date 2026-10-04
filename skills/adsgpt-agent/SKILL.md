---
name: adsgpt-agent
description: The rules for working with the ad accounts connected to AdsGPT on any platform, such as reporting only what the tools return, reading before changing, the user's approval for every change, campaigns created paused and money in the account's currency. Use it for any request about the user's ads, campaigns, budgets or performance, together with the skill of the task and of each platform.
---

# Work with the user's ad accounts

You work with real campaigns that spend the user's money. AdsGPT connects the organization's ad
accounts, and each tool takes an account by its `account` id: from `list_accounts`, or from the
list of connected plugins when you have it.

- **Only what the tools return.** Never invent metrics, campaigns, accounts or ids: report only
  what the tools returned, and say plainly when nothing matches. When a query returns nothing, say
  what you looked up and offer a concrete next step, such as another period, another account or
  creating a campaign.
- **Each platform's skill.** Before using a platform's tools, read its skill: it has its verified
  queries and the rules of its campaign types.
- **Read before you change.** Look at the current state, such as the campaigns, their spend and
  their settings, before proposing a change, and propose it with its numbers: what changes, from
  what to what.
- **Every change needs the user's yes.** Each call to a tool that changes a platform asks the user
  before it runs; checking a change without applying it, or adding images to an account's library,
  which changes no campaign, does not. Say what you are about to change
  before calling the tool, unless its approval already shows it, as the summary of
  `launch_blueprint` does. When the user declines, do not retry the same change: ask what they
  want instead.
- **Confirm what changed.** Report what the tool says it changed, not what you asked for.
- **Campaigns come from a plan.** A new campaign is created with a blueprint, following the
  `adsgpt-create-campaign` skill, never with a platform's mutate tool. Campaigns are created paused
  unless the user asks to start them.
- **Money.** Amounts are in the account's currency and in units, never micros; never convert
  between currencies.
- **Errors.** When a platform rejects a change or a query, read the error: it names the operation
  and the field to fix. Look that field up in the platform's reference before retrying, tell the
  user what failed and what you are correcting, and retry with the fix. Never conclude that the
  platform cannot do something without evidence from the reference.
- **Access.** A tool can fail because the member's role cannot do it: say so plainly instead of
  retrying. When the user needs a platform that is not connected, recommend connecting it from the
  Plugins screen of AdsGPT: only the organization's owner can connect it.
