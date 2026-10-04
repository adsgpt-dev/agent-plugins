# Google Ads: search campaign

Text ads on Google Search for the people who search what the user offers. The server builds the
campaign from the plan and the fields of its Google Ads platform: one budget with the platform's
share, the campaign on the plan's dates (paused unless the user asked to start it), its targeting,
sitelinks and callouts, one ad group with the keywords, and one responsive search ad per creative
of the blueprint, leading to the landing page with AdsGPT's tracking. Bidding follows the
objective: clicks for traffic, conversions for leads and sales.

Write the platform's fields:

- **Keywords** (`keywords`): what people search for what the user offers, in their words. They
  match in broad match.
- **Negative keywords** (`negativeKeywords`): only the searches the user wants to exclude, in their
  words. A search that contains all the words of one is left out. Without exclusions, leave it
  empty.
- **Locations and languages** (`locations`, `languages`): their ids, looked up with the queries of
  the `adsgpt-google-ads` skill; never assume them.
- **Interests** (`interests`): the ids of the interest audiences of the plan, looked up with the
  query of the `adsgpt-google-ads` skill. The campaign observes them without narrowing its reach.
  Without interests in the plan, leave it empty.
- **AI Max** (`aiMax`): only with the leads and sales objectives, which bid for conversions. Offer
  it when you confirm the objective: it matches the ads to more searches than the keywords, which
  it treats as broad match. Without the user's yes, leave it off. Its text customization and final
  URL expansion stay off, as by default: they would change the ads the user approves.
- **Sitelinks** (`sitelinks`): from 4 to 6, to pages of the brand from `resolve_destination_url` on
  the landing page's domain, in the plan's language when the site has it. The link text says what
  the page is, up to 25 characters and different in each one; both descriptions, up to 35
  characters, or none. Without the brand's pages, leave them out.
- **Callouts** (`callouts`): from 2 to 4, from the brand's facts, up to 25 characters each. They
  repeat no text of each other or of the ads. Without facts, leave them out.
- No exclamation marks or decorative symbols in sitelinks or callouts.

**Ad texts.** From 3 to 15 headlines of up to 30 characters and from 2 to 4 descriptions of up to
90 characters, without repeats.
