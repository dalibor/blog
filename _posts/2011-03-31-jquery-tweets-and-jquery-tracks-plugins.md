---
layout: post
title: "jQuery.tweets and jQuery.tracks plugins"
date: 2011-03-31 23:14:00 +0200
categories: [jquery, javascript, plugins]
summary: "Writing jQuery plugins for displaying recent tweets from Twitter and recent tracks from Last.fm."
permalink: /posts/24-jquery-tweets-and-jquery-tracks-plugins
---

I just extracted 2 small jQuery plugins from my blog which I use for displaying recent tweets from my [Twitter](http://twitter.com/dnasevic "Dalibor Nasević's Twitter profile") profile and recent tracks from my [Last.fm](http://www.last.fm/user/blackflasher "Dalibor Nasević's Last.fm profile") profile. Both plugins use the JSON APIs, and you can check them on my Github profile:

- [jQuery.tweets](https://github.com/dalibor/jQuery.tweets "jQuery.tweets plugin") - displays recent tweets from a Twitter profile. 
- [jQuery.tracks](https://github.com/dalibor/jQuery.tracks "jQuery.tracks plugin") - displays recent tracks from a Last.fm profile.

Clone the repositories, see index.html source for usage. And, read the source code if you are interested to build jQuery plugins.

Both plugins have dependency of 2 small jQuery plugins that you may also find interesting to use or just read their source code:

- [jquery-timeago.js](https://github.com/rmm5t/jquery-timeago "jQuery timeago") - approximate distance in time
- [jquery-autolink.js](http://kawika.org/jquery/js/jquery.autolink.js "jQuery autolink") - automatically creates links
