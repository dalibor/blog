---
layout: post
title: "Rake routes task"
date: 2011-01-13 21:59:00 +0100
categories: [rails, routes, rake]
summary: "Generating routes for a specific controller in Ruby on Rails application with rake routes task."
permalink: /posts/18-rake-routes-task
---

You can list all defined routes in your Rails application with:

```bash
rake routes
```

And what's more interesting, you can list only the routes for a single controller:

```bash
rake routes CONTROLLER=projects
```

Just a quick tip. :)
