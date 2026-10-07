# Google Ads: search campaign

Text ads on Google Search for the people who search what the user offers. The server builds the
campaign from the plan and the fields of its Google Ads platform: one budget with the platform's
share, the campaign on the plan's dates (paused unless the user asked to start it), its targeting,
sitelinks, callouts and structured snippets, one ad group with the keywords, and one responsive search ad per creative
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
- **Sitelinks, callouts and structured snippets.** A search campaign is not finished without them:
  without them its ads rank lower and get fewer clicks. Write them with the plan, not after the
  launch.
  - **Sitelinks** (`sitelinks`): from 4 to 6, each to a different page of the brand's site on the
    landing page's domain that you read and that exists, in the plan's language when the site has
    it. Point them to what a ready buyer clicks next, such as pricing, plans, reviews or contact,
    not to pages that repeat the ad. The link text says what the page is, up to 25 characters and
    different in each one, and both descriptions, up to 35 characters each.
  - **Callouts** (`callouts`): from 4 to 6, up to 25 characters each: concrete reasons to choose
    the brand that the site states, such as a figure, a guarantee or a service, not slogans. They
    repeat no text of each other or of the ads.
  - **Structured snippets** (`structuredSnippets`): one, or two with different headers, each a
    header from Google's list, in its translation to the language of the ads, and from 3 to 10
    values of up to 25 characters. Choose the header by what the values are, not by the business:
    every value must be one of the kind the header names, or the policy review rejects it.
    - **Types**: kinds of the product, such as ad formats (banner, native, interstitial) or plans.
    - **Service catalog**: services someone hires, such as mediation, payments or support.
    - **Brands**, **Models**, **Styles**, **Courses**, **Destinations**: names of brands, models,
      styles, courses or places.
  - When the site does not give 4 pages, 4 facts or 3 items of a kind, ask the user for what is
    missing, in the same question as anything else you still need.
  - No exclamation marks or decorative symbols in sitelinks or callouts.

**Ad texts.** From 3 to 15 headlines of up to 30 characters and from 2 to 4 descriptions of up to
90 characters, without repeats.
