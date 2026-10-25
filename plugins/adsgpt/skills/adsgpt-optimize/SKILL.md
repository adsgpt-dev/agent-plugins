---
name: adsgpt-optimize
description: Review how the user's ads perform on the platforms connected to AdsGPT and improve them, such as reports of a period, spend that does not convert, negative keywords, pausing what wastes money, moving budget to what works and pacing. Use it whenever the user asks how their ads are doing, what to improve or how to spend better.
---

# Review and optimize

## Review

- **The numbers come from the reports.** On Google Ads, `google_ads_report`: the account, its
  campaigns, ad groups, ads, keywords, search terms, the search terms that cost without converting
  (`wasted_spend`), the conversion actions, and by device, hour, location, demographic, audience,
  landing page, placement or asset; and `google_ads_compare_periods` for a period against the one
  before, with what moved and the changes made meanwhile. On Wortise Ads, `wortise_ads_report`: impressions,
  clicks and CTR per campaign, by app, city, country or device type, with no spend and no
  conversions. On Unity Ads, `unity_ads_report`: installs, spend in US dollars and cost per install
  per campaign, by country, creative pack, platform or store. On OpenAI Ads, `openai_ads_report`:
  impressions, clicks, spend in the account's currency, CTR, CPC, CPM and conversions per campaign,
  ad group or ad, by country, device, ChatGPT platform or product. On Meta Ads, `meta_ads_report`:
  impressions, reach, frequency, clicks, spend in the account's currency, CPM, CTR, CPC and the
  results of each action per campaign, ad set or ad, by age, gender, country or platform. On X Ads,
  `x_ads_report`: impressions, engagements, clicks, spend in the account's currency and CPM per
  campaign, line item or promoted post. On Reddit Ads, `reddit_ads_report`: impressions, reach,
  frequency, clicks, CTR, spend in the account's currency, CPC and eCPM per campaign, ad group or
  ad, by country, region, community, interest, gender or placement. On LinkedIn Ads,
  `linkedin_ads_report`: impressions, clicks, landing page clicks, cost in the account's currency,
  CTR, CPC, CPM and members reached per campaign group, campaign or creative, by the members'
  country, job function, seniority, industry or company size, or by placement or device. Write a
  query only for what no report covers.
- **The period.** Default to the last 30 days unless the user names one, and say which period each
  figure covers. Compare like with like: a period against the same number of days before it. Today
  is partial, and a few days are not a trend.
- **Measurement first.** Read the conversion actions before any figure about conversions: when the
  account measures none, its cost per conversion means nothing. Say so before showing it. On
  Google Ads, offer to create the missing one (`google_ads_create_conversion_action`), and check
  what a campaign bids for (its `bidding` section) when its conversions are not the business's.
- **The platform's own suggestions.** On Meta Ads, read the account's opportunity score and Meta's
  recommendations (`getAdAccountRecommendations`, as the Meta Ads skill says); on Google Ads, the
  `recommendations` report. Offer, after the numbers, the ones that fit: the improvement each
  platform expects is its estimate, not a result. On Google Ads, apply the chosen ones with
  `google_ads_apply_recommendations` and dismiss those the user rejects with
  `google_ads_dismiss_recommendations`, by their ids.
- **Lead with the answer.** The biggest problem and the biggest opportunity, each with its numbers,
  and one recommendation. Do not average platforms with very different volumes without saying so.
- **Offer, do not act.** A review changes nothing: propose the change and wait for the user's yes.

## Optimize

Before cutting anything:

- **Check the measurement.** A campaign that seems not to convert may not be measured: pausing it
  would stop one that works.
- **Check the volume.** A few clicks without conversions are not evidence: compare the spend with
  what a conversion costs in the account before calling something a loser.

Then fix it, in this order:

1. **Negative keywords before pauses.** They stop the searches that waste money and keep the
   campaign running. The `wasted_spend` report lists them; on Display, Video and Performance Max,
   the `placements` report lists the sites and apps to exclude with `google_ads_add_targeting`. On Google Ads, add them with
   `google_ads_add_negative_keywords`, all the ones of a campaign in one call, in broad match unless
   the user asks for another. When the same terms waste money in several campaigns, put them in a
   shared list (`google_ads_create_negative_keyword_list`) applied to all of them.
2. **Pause the narrowest thing** that solves the problem: an ad, then an ad group, then the
   campaign. On Google Ads, with `google_ads_update_status`. On Wortise Ads, a whole campaign with
   `wortise_ads_update_status`, or a creative with Wortise Ads' edit tool, where the client offers it, setting its `status` to
   `disabled`. On Unity Ads, with `unity_ads_update_status`: pausing is always allowed. On OpenAI Ads, with
   `openai_ads_update_status`, an ad, an ad group or a campaign. On Meta Ads, with
   `meta_ads_update_status`, an ad, an ad set or a campaign. On X Ads, a line item or a campaign
   with `x_ads_update_status`, or a post by removing its promotion with X Ads' edit tool, where the client offers it. On Reddit
   Ads, with `reddit_ads_update_status`, an ad, an ad group or a campaign. On LinkedIn Ads, with
   `linkedin_ads_update_status`, a creative, a campaign or a campaign group.
3. **Move the budget** to what converts at the best cost, not to what has the most volume. On
   Google Ads, with `google_ads_update_budget`. Prefer steps to doubling a budget at once: a large
   change makes automated bidding learn again. On Wortise Ads, with `wortise_ads_update_budget`:
   its budget is the campaign's total, and a raise comes out of the organization's balance. On Unity Ads, with `unity_ads_update_budget`: its `total` and `daily` limits in US dollars. On
   OpenAI Ads, with `openai_ads_update_budget`: its limit in the account's currency, daily or
   lifetime as the campaign has it. On Meta Ads, with `meta_ads_update_budget`: the budget of the
   campaign when it has a campaign budget, or of each ad set, in the account's currency, daily or
   lifetime as it has it. On X Ads, with `x_ads_update_budget`: the daily or total budget of the
   campaign, or of a line item when its campaign has no daily budget. On Reddit Ads, with
   `reddit_ads_update_budget`: the budget of each ad group, or of the campaign when it has a
   campaign budget, in the account's currency, daily or total as it has it, of at least 5 per day.
   On LinkedIn Ads, with `linkedin_ads_update_budget`: the budget of each campaign, or of a
   campaign group with one, in the account's currency, daily or total as it has it, of at least
   the daily budget LinkedIn prices for its targeting.

Never remove when pausing does: removing loses the history. Name what would be lost and ask.

## Pacing

Compare the spend so far with the days elapsed of the period. A campaign that spends less than its
budget may be limited by its bids, its targeting or its audience, not by its budget: check that
before raising it. On Google Ads, most campaigns can spend up to twice their average daily budget
on one day, and the user never pays more than that in a day nor more than 30.4 times it in a month:
a single day above the budget is not a mistake.

## After each change

Report what the tool says it changed, and what to expect: automated bidding takes time to learn
again, and the next days of data say whether the change worked.
