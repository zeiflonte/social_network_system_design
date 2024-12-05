# Social network for travelers

Social Network System Design for [course by System Design](https://balun.courses/courses/system_design).

### Functional requirements:

- publishing travel posts with photos, a short description and a link to a specific place of travel
- show the user's feed based on subscriptions in reverse chronological order
- search for popular travel destinations and show posts from these places
- view the feed of other travelers in reverse chronological order
- rating posts of other travelers
- commenting posts of other travelers
- subscription to other travelers
  
### Non-functional requirements:

- 10 000 000 DAU
- activities of users (on average):
  - one user publishes 3 travel posts in month (0.1 post per day)
  - one user views their feed 4 times per day and scrolling feed for 2 times (retrives the first page and makes 1 pagination request, resulting in seeing 20 posts)
  - one user searches for popular travel destinations for 0.2 times per day
  - one user views the feed of other travelers for 5 times per day
  - one user reacts to 8 posts per day (every 5th post)
  - one user reads comments of 16 posts per day (every 2.5 posts)
  - one user leaves 0.8 comments per day (every 50th post)
  - one user subscribes to 2 users daily
  - one user attaches 3 photos to one post
- majority of users are be located in CIS
- data is persisted forever
- availability 99,95%
- activity peaks before the summer holiday season (x3 more requests) and the winter holiday season (x2 more requests)
- limits:
  - max subscriber amount is 10 000
  - service returns last 5 000 posts in user's feed based on subscriptions
  - max amount of photos for the single post is 10
  - one user can create up to 500 posts per day
- time limits:
  - any feed should be loaded for 1.5 seconds or less
  - comments page should be loaded for 1.5 second or less

## Basic calculations

### RPS calculations

RPS (write posts):

    Each user publishes 0.1 post per day
    RPS = 10 000 000 / 86 400 / 10 ~= 12

RPS (read posts):

    Each user daily retreives 8 pages of posts from feed + 0.2 pages from search + 5 pages from others' feeds, 
    RPS = 10 000 000 / 86 400 * 13.2 ~= 1527

RPS (write reactions):

    Each user reacts to 8 posts per day
    RPS = 10 000 000 / 86 400 * 8 ~= 926

RPS (write comments):

    Each user writes comments to 0.8 posts per day
    RPS = 10 000 000 / 86 400 * 0.8 ~= 93

RPS (read comments):

    Each user reads comments of 16 posts per day
    RPS = 10 000 000 / 86 400 * 16 ~= 1852

Total RPS:

    Read: 3379
    Write: 1031

### Traffic calculations

Traffic (write posts):

    RPS = 12
    upper bound schema size:
    3 pictures = 10MB * 3 = 30 MB (server accepts not compressed yet) / take 1.5MB of memory after compression
    3 picture url = 90 B
    description = 200 B
    location_tag (location name) = 100 B
    Total (client-side compression): 1.5MB * 12 = 18 MB/s
    Total (server-side compression): 30MB * 12 = 360 MB/s

Traffic (read posts):

    RPS = 1527
    upper bound schema size:
    per 1 post:
    id = 8 B
    3 pictures = 0.5MB * 3 = 1.5 MB
    3x picture_url = 90B * 3 = 270 B
    description = 200 B
    location_tag (location name) = 100 B
    reactions_count = 8 B
    created_at = 8 B
    Total: 1.5 MB * 1527 = 2291 MB/s ~= 2.3 GB/s
    Total per 10 posts: 22910 MB/s ~= 23 GB/s

Traffic (write reactions):

    RPS = 926
    upper bound schema size:
    post_id = 8B
    user_id = 8B
    reaction_type = 1B
    Total: 15742 B/s ~= 15 kB/s

Traffic (write comments):

    RPS = 93
    post_id = 8B
    user_id = 8B
    text = 200B
    Total: 20088 B/s = 20 kB/s

Traffic (read comments):

    RPS = 1852
    per 1 comment:
    post_id = 8B
    author_id = 8B
    text = 200B
    Total: 400032 B/s
    Total per 10 comments: 390 kB/s

Total Traffic:

    Read: 23 GB/s
    Write: 18-360 MB/s
