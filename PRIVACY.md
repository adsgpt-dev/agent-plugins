# Privacy

What the AdsGPT package for AI clients sends, and what AdsGPT does with it. The package itself
collects nothing: it is the address of the AdsGPT MCP server and skills the model reads. Everything
below happens on the AdsGPT server when your client calls one of its tools.

## What AdsGPT receives

- **Your sign-in.** Your client signs in to your AdsGPT account with OAuth 2.1. AdsGPT keeps the
  client's registration and the tokens it issued, to know which member and organization each call
  acts for.
- **The inputs of each tool call**, as your client's model writes them: account ids, queries,
  campaign plans, ad texts, image URLs, YouTube links and landing page URLs. AdsGPT does not
  receive your conversation.

## What AdsGPT stores

In your AdsGPT organization, available to its members as their roles allow:

- the campaign plans, their ads, images and videos, and the campaigns they launched;
- the brand of each landing page: what its site says, its pages and its images, read once per site;
- a log of every change made to your ad accounts: what changed, what it had before, and the member
  and the client it came from.

## Who else receives data

- **The ad platforms you connected, such as Google Ads,** through their APIs with the access your
  organization granted: the queries, reports and changes your client asks for, and the images a
  plan uploads to the account.
- **Firecrawl,** which reads the landing page of a campaign the first time AdsGPT sees its site.
- **The sites of the images you give by URL,** which AdsGPT downloads to check and upload them.

## What your client receives

The results of its tool calls: your connected accounts, the reports and query results of your ad
platforms, including Google Ads data, the plans and their issues, and the changes made. Your
client's provider handles them under its own privacy policy.

## Your choices

Disconnect an ad platform or revoke a client's access from AdsGPT at any time. To ask about your
data or have it deleted, open an issue in this repository.
