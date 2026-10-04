# Google Ads: Performance Max campaign

One campaign across Search, YouTube, Display, Discover, Gmail and Maps: Google combines the texts,
images and logo of each asset group and chooses where to show them. The server builds it from the
plan and the fields of its Google Ads platform:

- one budget with the platform's share, as a total for the dates or per day;
- the campaign on the plan's dates, paused unless the user asked to start it, bidding for
  conversions, the only bidding Performance Max takes;
- its locations and languages;
- the brand's name and logo on the campaign;
- one asset group per creative of the blueprint, with its texts and the images of its idea,
  leading to the landing page with AdsGPT's tracking.

Google's text generation and final URL expansion stay off: they would change the ads the user
approves.

Write the platform's fields:

- **Business name** (`businessName`): the brand's name, up to 25 characters.
- **Locations and languages** (`locations`, `languages`): their ids, looked up with the queries of
  the `adsgpt-google-ads` skill; never assume them. The campaign targets locations and languages
  only: tell the user when the plan has age, gender, interests or keywords, and leave the other
  fields of the platform out.

What else it needs:

- **Conversions.** It bids for conversions, which the account must be measuring: look up its
  conversion actions as the `adsgpt-google-ads` skill says before proposing it.
- **Logo.** The server uses `logo` when you set it, the id of a square image of the account's
  library; otherwise the logo the account already uses or, without one, the logo of the plan's
  `brand`, when it has one, which it adds to the account as a square. Without any, the platform has
  an issue: tell the user. When neither the account nor the plan has one, ask the user for a link to
  their logo, add it to the account with `google_ads_upload_images` as a logo and set its id as
  `logo`.
- **Images.** Each creative needs images of its idea in 1.91:1 and 1:1. Add them with
  `save_image_creatives`, each with the text creative it goes with, from images that already exist,
  in this order: the account's library (`google_ads_list_assets`), which usually has them, the image
  the brand's site shares, and URLs the user gives when neither has them. Never an image an AI model
  generates.
- **Ad texts.** From 3 to 15 headlines of up to 30 characters and from 2 to 5 descriptions of up to
  90 characters, without repeats, and from 1 to 5 long headlines of up to 90 characters.
