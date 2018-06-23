# Podcacher
## Offline Podcast server
---
## Purpose
I am a sailor. Just about the only time that I have time to listen to podcasts is on night watch.
Often I will be away from unlimited high speed internet for months at a time. As a result,
I needed a way to store podcasts when I had lots of free internet, and listen to them when I had little

Many of us sailors would just wget the files, and trade them via hard drive, but then you can't use your
podcast app to listen to them.

Podcacher solves this problem. Once installed, click on the "New Podcast" link, and enter the URL of your
favorite feed. If you, like me, already have a lot of cached files, you can supply the path to that
directory as well. When you click on "Create Podcast" a background job will set up your podcast, and
if you supplied a cache dir, it will import those files too.

Give that 5 minutes to complete, and then "View" your podcast. This will bring up a page that contains all
of the episodes that have been published by the remote server. Anything that is locally cached will have a
"Download" button under the episode description. Click "Download new episodes" to update
from the remote server. It will skip any episodes that already have a media file.

## Installation
### Prerequisites
ruby 2.4 or greater
rubygems
bundler `gem install bundler`

## Steps
clone this repository
`cd podcacher`
`bundle install`
`rails db:setup`
`rails db:migrate`


## Todo
Definitely scheduling would be nice. Also one off episode downloads
