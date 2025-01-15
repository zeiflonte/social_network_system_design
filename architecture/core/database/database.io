// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

Table follows {
  following_user_id unsigned_integer
  followed_user_id unsigned_integer
  created_at timestamp 
}

Table seen_posts {
  user_id unsigned_integer
  post_id unsigned_integer
  created_at timestamp 
}

Table users {
  id unsigned_integer [primary key]
  username varchar(50)
  created_at timestamp
}

Table posts {
  id unsigned_integer [primary key]
  description varchar(300)
  user_id unsigned_integer
  place_id unsigned_integer
  created_at timestamp
}

Table places {
  id unsigned_integer [primary key]
  name varchar(300)
}

Table images {
  id unsigned_integer [primary key]
  post_id unsigned_integer
}

Table rates {
  id unsigned_integer [primary key]
  user_id unsigned_integer
  post_id unsigned_integer
}

Table comments {
  id unsigned_integer [primary key]
  user_id unsigned_integer
  post_id unsigned_integer
  parent_id unsigned_integer
  text varchar(300)
}

Ref: seen_posts.post_id > posts.id
Ref: seen_posts.user_id > users.id

Ref: comments.post_id > posts.id
Ref: comments.user_id > users.id
Ref: comments.parent_id > comments.id

Ref: posts.place_id > places.id

Ref: rates.post_id > posts.id
Ref: rates.user_id > users.id

Ref: posts.user_id > users.id // many-to-one

Ref: images.post_id > posts.id

Ref: users.id < follows.following_user_id

Ref: users.id < follows.followed_user_id
