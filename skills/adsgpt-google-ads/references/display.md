# Google Ads: Display campaign

Responsive image ads on the sites and apps of the Google Display Network: Google combines the
texts, images and logo of each ad for each placement, and finds the people with optimized
targeting. The server builds it from the plan and the fields of its Google Ads platform:

- one budget with the platform's share, as a total for the dates or per day;
- the campaign on the plan's dates, paused unless the user asked to start it, with its locations
  and languages, bidding per thousand viewable impressions on awareness, for clicks on traffic
  and for conversions on leads and sales;
- one ad group and one responsive display ad per creative of the blueprint, with its texts, the
  images of its idea, the brand's name and logo, leading to the landing page with AdsGPT's
  tracking.

Write the platform's fields:

- **Business name** (`businessName`): the brand's name, up to 25 characters.
- **Locations and languages** (`locations`, `languages`): their ids, looked up with the queries of
  the `adsgpt-google-ads` skill; never assume them. The campaign targets locations and languages
  only: tell the user when the plan has age, gender, interests or keywords, and leave the other
  fields of the platform out.
- **CPM bid** (`cpmBid`), only for awareness: the most the campaign pays per thousand viewable
  impressions, in units of the account's currency. Ask the user how much they want to pay. When
  they have no figure in mind, propose one from the account's history, and say where it comes
  from: the viewable CPM of its Display campaigns in the last 30 days,
  `SELECT campaign.name, metrics.active_view_cpm, metrics.active_view_impressions FROM campaign WHERE campaign.advertising_channel_type = 'DISPLAY' AND segments.date DURING LAST_30_DAYS AND metrics.active_view_impressions > 0`
  (`active_view_cpm` is in micros). Without history, say there is none and ask for a figure:
  never invent a market price. A low bid shows few ads. Put the bid in the launch summary.

What else it needs:

- **Conversions.** On leads and sales it bids for conversions, which the account must be
  measuring: look up its conversion actions as the `adsgpt-google-ads` skill says before proposing
  it.
- **Logo.** The server uses `logo` when you set it, the id of a square image of the account's
  library; otherwise the logo the account already uses or, without one, the brand's logo from
  `resolve_destination_url`, which it adds to the account as a square. Without any, the ads show no
  logo.
- **Images.** Each creative needs images of its idea in 1.91:1 and 1:1. Add them with
  `save_image_creatives`, each with the text creative it goes with, from images that already
  exist: the account's library (`google_ads_list_assets`), the brand's site image from
  `resolve_destination_url`, or URLs the user gives. Never an image an AI model generates.
- **Ad texts.** From 1 to 5 headlines of up to 30 characters and from 1 to 5 descriptions of up to
  90 characters, without repeats, and one long headline of up to 90 characters.
- **Audiences.** Remarketing and custom audiences are not supported yet: Google finds the people.
