---
name: adsgpt-google-ads
description: Read and change the Google Ads accounts connected to AdsGPT with its google_ads_* tools (performance reports, GAQL queries, field and API reference, the account's images and videos, image uploads, budget and status changes, negative keywords), and the objectives, campaign types and rules for creating Google Ads campaigns. Use it before any Google Ads query or change, and when a campaign plan includes Google Ads.
---

# Google Ads

Google's advertising platform. The tools report performance (`google_ads_report`), read
campaigns, ad groups, ads, keywords, budgets and their metrics (`google_ads_search`, with GAQL), look up the GAQL fields (`google_ads_fields`) and
the API reference (`google_ads_docs`), list the images and videos of the account's library
(`google_ads_list_assets`), upload images to it (`google_ads_upload_images`), change a campaign's
budget (`google_ads_update_budget`),
pause or enable campaigns, ad groups or ads (`google_ads_update_status`) and add negative
keywords to a campaign (`google_ads_add_negative_keywords`).
Each tool takes an account by its `account` id.

## Reports

- For performance, use `google_ads_report` before writing a query: the account, its campaigns, ad
  groups, ads, keywords or search terms, the search terms that cost without converting
  (`wasted_spend`, the source of negative keywords) and the conversion actions, with their money in
  the account's currency. Write a GAQL query only for what no report covers.
- Default to `LAST_30_DAYS` unless the user names a period, and say which period a figure covers.
  Ask for one row per day only to show a trend.

## Queries

- Select only the fields you need and filter by date with `segments.date`. GAQL joins conditions
  only with AND, never OR: use IN for several values, or one query per LIKE pattern. When a result
  is `truncated`, narrow the query instead of asking for more rows.
- Never guess a GAQL field name. List a resource's fields with `google_ads_fields` (such as
  `user_interest.`) before querying one whose fields you do not know, and whenever Google Ads
  answers "Unrecognized field". The queries below are verified: run them as they are, without
  listing their fields first.
- Never assume the id of a catalog item, such as an interest, a location, a language or a bidding
  strategy: look it up with a query and, if you cannot find it, say so and ask.
  - A country, by its English name and ISO code:
    `SELECT geo_target_constant.id, geo_target_constant.name, geo_target_constant.country_code, geo_target_constant.target_type FROM geo_target_constant WHERE geo_target_constant.name = 'Argentina' AND geo_target_constant.country_code = 'AR'`.
  - A language, by its ISO 639-1 code:
    `SELECT language_constant.id, language_constant.name, language_constant.code FROM language_constant WHERE language_constant.code = 'es'`.
  - An interest audience, among `IN_MARKET` and `AFFINITY` interests, by a word of its English
    name, only for a campaign type whose rules take interests, such as search; the others target
    locations and languages only:
    `SELECT user_interest.user_interest_id, user_interest.name, user_interest.taxonomy_type FROM user_interest WHERE user_interest.name LIKE '%marketing%' AND user_interest.taxonomy_type IN ('IN_MARKET', 'AFFINITY')`.
    Do not select `user_interest.availabilities`: it lists every language and channel of each
    interest and fills the context. Saving the plan lists, among its issues, an interest the
    campaign type does not take: then choose another.
- When a query fails, tell the user what you tried and what you are correcting; never go on as if
  it had worked.
- Money fields ending in `_micros` are millionths of the account's currency: divide them by
  1,000,000 before showing them.

## Changes

- Change a campaign's budget with `google_ads_update_budget`, by the campaign's id: it keeps the
  budget daily or total, refuses one other campaigns share and says the amount before and after.
- Pause or enable campaigns, ad groups or ads with `google_ads_update_status`, by their ids: an ad
  is `<ad group id>~<ad id>`, both in the `ads` report. Pause the narrowest thing that solves the
  problem.
- Add negative keywords to a campaign with `google_ads_add_negative_keywords`, by the campaign's
  id, in broad match unless the user asks for another.
- Each change has its own tool. When the user asks for one no tool makes, such as editing an ad's
  texts, adding keywords or changing bids, say so plainly and suggest making it in Google Ads,
  without trying another tool.
- Read the reference with `google_ads_docs` when you are unsure of a field of a query or of an
  object, read by its name (`resources.Campaign`). Look up there the field a Google Ads error
  names.

## Images and logo

The ads show images and a logo the account's library has: saving a campaign plan adds the ones it
lacks, without anything else to do.

- List the library with `google_ads_list_assets` before asking the user for images: the account
  usually has images and a logo it already uses. An image with an `aspectRatio` fits the ads, and
  its URL can go into a plan with `save_image_creatives`; one without it has another shape or is too
  small for the ads, and can still be a logo.
- To have a new image ready for a campaign that already runs, upload it to the library with
  `google_ads_upload_images`; linking it to that campaign is made in Google Ads.
- Never an image an AI model generates.

## Campaign plans

Google Ads supports these objectives, each with the campaign types that fit it. Propose the type
that fits the plan and confirm it with the objective.

| Objective     | Campaign types                               |
| ------------- | -------------------------------------------- |
| awareness     | display                                      |
| traffic       | search, demand-gen, display                  |
| engagement    | demand-gen                                   |
| leads         | search, performance-max, demand-gen, display |
| sales         | search, performance-max, demand-gen, display |
| app-promotion | app                                          |

- **search:** text ads on Google Search for the people who search what the user offers; needs
  keywords. Its rules: `references/search.md`.
- **app:** ads that get installs of the app across Search, Google Play, YouTube, Discover and the
  Display Network; needs the app in its store. Its rules: `references/app.md`.
- **performance-max:** one campaign across Search, YouTube, Display, Discover, Gmail and Maps,
  where Google combines the texts, images and logo of each asset group and chooses where to show
  them. It bids for conversions, so it needs an account that measures them; propose it for leads or
  sales when the user wants reach beyond search, and search when they want to control which
  searches show the ads. Its rules: `references/performance-max.md`.
- **demand-gen:** image and video ads in the feeds of YouTube, Discover and Gmail, on YouTube and
  on the Display Network, for people who are not searching yet but would want what the user
  offers; or only on YouTube when the user asks for it. Propose it for engagement, for traffic or
  conversions beyond search, for a visual product, and when the user has videos on YouTube. Its
  rules: `references/demand-gen.md`.
- **display:** image ads on the sites and apps of the Display Network, where Google finds the
  people with optimized targeting. The only one for awareness, which pays per thousand viewable
  impressions; for traffic or conversions it reaches people across those sites and apps, beyond
  search. Its rules: `references/display.md`.
- **Leads and sales** bid for conversions, which the account must be measuring. Before proposing
  them, look up the conversion actions that bidding uses:
  `SELECT conversion_action.id, conversion_action.name, conversion_action.category FROM conversion_action WHERE conversion_action.status = 'ENABLED' AND conversion_action.primary_for_goal = TRUE`.
  Without any, the account does not measure conversions: say so and propose the traffic objective
  instead.

Once the user confirmed the campaign type, read its rules: they say how to fill the fields of the
blueprint's Google Ads platform. The server builds the campaign from them.
