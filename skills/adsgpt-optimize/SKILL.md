---
name: adsgpt-optimize
description: Review how the user's ads perform on the platforms connected to AdsGPT and improve them, such as reports of a period, spend that does not convert, negative keywords, pausing what wastes money, moving budget to what works and pacing. Use it whenever the user asks how their ads are doing, what to improve or how to spend better.
---

# Review and optimize

## Review

- **The numbers come from the reports.** On Google Ads, `google_ads_report`: the account, its
  campaigns, ad groups, ads, keywords, search terms, the search terms that cost without converting
  (`wasted_spend`) and the conversion actions. Write a query only for what no report covers.
- **The period.** Default to the last 30 days unless the user names one, and say which period each
  figure covers. Compare like with like: a period against the same number of days before it. Today
  is partial, and a few days are not a trend.
- **Measurement first.** Read the conversion actions before any figure about conversions: when the
  account measures none, its cost per conversion means nothing. Say so before showing it.
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
   campaign running. The `wasted_spend` report lists them. On Google Ads, add each one with
   `google_ads_mutate`, as a negative criterion of its campaign, in broad match unless the user
   asks for another:
   `{ "campaignCriterionOperation": { "create": { "campaign": "customers/<customer id>/campaigns/<campaign id>", "keyword": { "text": "<search term>", "matchType": "BROAD" }, "negative": true } } }`.
2. **Pause the narrowest thing** that solves the problem: an ad, then an ad group, then the
   campaign. On Google Ads, with `google_ads_update_status`.
3. **Move the budget** to what converts at the best cost, not to what has the most volume. On
   Google Ads, with `google_ads_update_budget`. Prefer steps to doubling a budget at once: a large
   change makes automated bidding learn again.

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
