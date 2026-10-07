# Google Ads: Demand Gen campaign

Image and video ads in the feeds of YouTube, Discover and Gmail, on YouTube's videos and Shorts,
and on the Display Network, for people who are not searching yet: Google combines the texts,
images, videos and logo of each ad for each place. The server builds it from the plan and the
fields of its Google Ads platform:

- one budget with the platform's share, as a total for the dates or per day;
- the campaign on the plan's dates, paused unless the user asked to start it, bidding for clicks
  on traffic and engagement and for conversions on leads and sales;
- one ad group on every channel, or only on YouTube (in-stream, in-feed and Shorts), with its
  locations and languages;
- per creative of the blueprint, an image ad with the images of its idea and a video ad with its
  YouTube videos, each with its texts and the brand's name and logo, leading to the landing page
  with AdsGPT's tracking.

Write the platform's fields:

- **Business name** (`businessName`): the brand's name, up to 25 characters.
- **Only YouTube** (`youtubeOnly`): true only when the user asks to show the ads on YouTube alone;
  otherwise Google chooses among all the channels, which usually reaches more people for the
  money.
- **Locations and languages** (`locations`, `languages`): their ids, looked up with the queries of
  the `adsgpt-google-ads` skill; never assume them. The campaign targets locations and languages
  only: tell the user when the plan has age, gender, interests or keywords, and leave the other
  fields of the platform out.

What else it needs:

- **Conversions.** On leads and sales it bids for conversions, which the account must be
  measuring: look up its conversion actions as the `adsgpt-google-ads` skill says before proposing
  it.
- **Budget.** Google asks a total budget for at least a minimum per day of the dates: when the
  platform rejects the amount, tell the user and propose a larger budget or fewer days.
- **Logo.** The server uses `logo` when you set it, the id of a square image of the account's
  library; otherwise the logo the account already uses or, without one, the logo of the plan's
  `brand`, when it has one, which it adds to the account as a square. Without any, the platform has
  an issue: tell the user. When neither the account nor the plan has one, ask the user for a link to
  their logo, add it to the account with `google_ads_upload_images` as a logo and set its id as
  `logo`.
- **Images or videos.** Each creative needs at least one image or one video of its idea.
- **Images**, in 1.91:1 or 1:1; both reach more places. Add them with `save_image_creatives`, each
  with the text creative it goes with, from images that already exist, in this order: the account's
  library (`google_ads_list_assets`), which usually has them, the image the brand's site shares, and
  URLs the user gives when neither has them. Never an image an AI model generates.
- **Videos.** The user's videos on YouTube, public or unlisted: ask for their links when the user
  mentions video or YouTube, and save them with `save_video_creatives`, each with the text creative
  it goes with, up to 5 per creative. Horizontal (16:9), square or vertical (9:16, the one Shorts
  show), of at least 5 seconds; under 10 seconds they do not show before YouTube videos. A video
  YouTube cannot find, such as a private one, comes back as an issue: ask the user to make it
  public or unlisted. AdsGPT does not upload videos to YouTube yet: a user without the video on
  YouTube uploads it there first.
- **Ad texts.** From 1 to 5 headlines of up to 40 characters and from 1 to 5 descriptions of up to
  90 characters, without repeats, and from 1 to 5 long headlines of up to 90 characters, which the
  video ad shows.
