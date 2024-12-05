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
  - one user views their feed 2 times per day and scrolling feed for 2 times (retrives the first page and makes 1 pagination request), resulting in seeing 20 posts
  - one user searches for popular travel destinations for 0.2 times per day
  - one user views the feed of other travelers for 3 times per day
  - one user rates 4 posts per day (every 5th post)
  - one user leaves 0.4 comments per day (every 50th post)
  - one user subscribes to 1 user daily
  - one user attaches 2 photos to one post
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
