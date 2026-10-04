---
name: adsgpt-create-campaign
description: Create an ad campaign with the user on one or more platforms connected to AdsGPT, as a blueprint (one campaign plan the user approves once and that launches on every platform), from the objective to the launch. Use it whenever the user asks to create, launch or plan a campaign.
---

# Create a campaign

You are creating a campaign with the user. The plan is a **blueprint**: one campaign plan for one
or more platforms, which the user approves once and which then launches on every platform. Follow
these steps in order. Ask one thing at a time, and skip what the user already said.

1. **Objective and campaign type.** The objective is one of: awareness, traffic, engagement,
   leads, sales, app promotion. Infer it from what the user wants, read the skill of each
   platform for the objectives it supports and their campaign types, and confirm the objective
   and the campaign type of each platform in one question. Once confirmed, read the rules of
   each campaign type.
2. **Platforms and accounts.** The mentioned plugins, otherwise the connected ones. When a plugin
   has several accounts, ask which one. A platform that does not support the objective, or that
   has no skill, is left out: say so.
3. **Destination.** The landing page. Keep any UTM parameters the user gives: the blueprint uses
   them. Read the landing page and the pages of its own domain that it links to, and keep in mind
   only what they state, in the language of the site: what the brand offers and to whom, the
   facts the ads can claim, such as figures, guarantees or plans, the pages a sitelink can lead
   to, and the image the site shares. When you cannot read the site, tell the user and ask what
   it offers instead of guessing. To promote an app, the link to the app in its store, which gives
   the app and its store; read the user's site too when they give it.

   The assets each campaign type needs, such as images, a logo or links to pages, come first from
   what the account already has, then from what the site states; ask the user only for what is
   still missing. The skill of each platform says how to find them and which ones its campaign
   types cannot go without.

4. **Audience.** Locations, languages, age and gender, and interests, in the user's words.
   Propose a broad audience when they have none in mind.
5. **Budget and dates.** Ask in one question how much they want to invest and for how long, in
   the user's currency. By default it is a total for the dates, which caps the spend; a daily
   amount without an end date is an ongoing campaign. Dates are in each account's time zone,
   where the connected plugins give today's date; without a start date from the user, the
   campaign starts today. The budget type cannot change once the
   campaign exists. With several platforms, propose an even split and let the user change it.
   When an account has another currency, ask for that platform's amount in the account's
   currency: there is no conversion. Amounts are always in currency units, never micros.
6. **Creatives.** Ask once whether they have an idea or something in particular in mind, or leave
   the ads to the creative team. Their idea, in their words, is the `creativeBrief`. When they
   leave it to the creative team, leave `creativeBrief` out: never write instructions of your own
   there, since the creative team reads it as the user's.
7. **What each platform needs**: the fields of its platform in the blueprint, such as keywords,
   from the rules of its campaign type.
8. **Build the blueprint:**
   1. `save_blueprint` with the plan and the fields of each platform. Keep its `_id`.
   2. Its creatives: write them with the `adsgpt-write-ads` skill, within the text limits of
      each campaign type, and save them with `save_creatives`. When the campaign type takes
      images or videos, add them with `save_image_creatives` or `save_video_creatives`, as the
      rules of the campaign type say. With the creatives, the server builds the campaign of each
      platform and checks it with the platform.
   3. When a result lists `issues`, fix exactly those: the plan or a platform's fields with
      `save_blueprint`, which checks again. When a creative's texts cause one, leave that
      creative out of `creatives` with `save_blueprint` and write a new one.
   4. When you tell the user what the plan has, name every creative with all its images and
      videos: the ones the creative team drew and the ones you added.
9. **Launch.** Call `launch_blueprint` with the plan in its `summary`, in up to 600 characters:
   platforms, budget per platform, dates, the audience each platform targets, ads, and whether the
   campaigns start paused. When a campaign type leaves out part of the plan's audience, such as
   interests on a campaign that targets locations and languages only, say so in the summary: name
   only the targeting the platform applies. The approval card shows that summary with the saved
   plan: call the tool without writing the plan in text before it. The user approves or rejects
   the whole plan there, once. Never ask for the approval in text: calling the tool is the
   question.
   Then tell them what launched on each platform, and what failed and why. The result has the
   campaign each platform created, with its id, name and status as the platform confirmed them:
   it is the check of the launch, without querying the platform again.

- Never apply a change of the plan with a platform's mutate tool: only `launch_blueprint`
  launches.
- Campaigns are created paused unless the user asks to start them.
- When the user asks to change the plan after saving, update the blueprint with `save_blueprint`.
  A launched blueprint does not change: another plan is another blueprint.
