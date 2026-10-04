# Google Ads: app campaign

An app install campaign: Google shows the app's ads on Search, Google Play, YouTube, Discover and
the Display Network, and optimizes for installs. The server builds it from the plan and the fields
of its Google Ads platform: a daily budget (a total is divided by the days of the plan, since the
API takes no total), the campaign with the blueprint's app on the plan's dates (paused unless the
user asked to start it), bidding for installs without a target cost, its locations and languages,
and one ad group with one app ad per creative of the blueprint.

- **App.** The blueprint's `destination.app`: its id in its store (the package name on Google
  Play, the numeric id on the App Store) and the store, from the store link the user gives; the
  link is the destination's `url`. Neither changes once the campaign exists.
- **Locations and languages** (`locations`, `languages`): their ids, looked up with the queries of
  the `adsgpt-google-ads` skill; never assume them. The campaign targets locations and languages
  only: tell the user when the plan has age, gender or interests, and leave the other fields of
  the platform out.
- **Measurement.** Google Play installs are measured without setup. For an App Store app, tell the
  user that measuring installs needs Firebase or a third-party app analytics tool.
- **Ad texts.** From 2 to 5 headlines of up to 30 characters and from 1 to 5 descriptions of up to
  90 characters, without repeats.
- **Images.** Optional: each app ad shows the images of its creative's idea, added with
  `save_image_creatives`. Google also takes images and videos from the store listing.
