/*
For any two users, the app needs to quickly show a list of the friends they have in common.
Given two usernames, `lovelytrust487` and `exceptionalinspiration482`, find the user IDs of their mutual friends.
A mutual friend is a user that both `lovelytrust487` and `exceptionalinspiration482` count among their friends.
Ensure your query uses the index automatically created on primary key columns of the `friends` table.
This index is called `sqlite_autoindex_friends_1`.
*/

SELECT "friend_id"
FROM "friends"
WHERE "user_id" = (
    SELECT "id"
    FROM "users"
    WHERE "username" = 'lovelytrust487'
    )
INTERSECT
SELECT "friend_id"
FROM "friends"
WHERE "user_id" = (
    SELECT "id"
    FROM "users"
    WHERE "username" = 'exceptionalinspiration482'
);

/*
+-----------+
| friend_id |
+-----------+
| 1603      |
| 2142      |
| 2438      |
+-----------+
*/

/*
EXPLAIN QUERY PLAN
   ...> SELECT "friend_id"
   ...> FROM "friends"
   ...> WHERE "user_id" = (
   ...>     SELECT "id"
   ...>     FROM "users"
   ...>     WHERE "username" = 'lovelytrust487'
   ...>     )
   ...> INTERSECT
   ...> SELECT "friend_id"
   ...> FROM "friends"
   ...> WHERE "user_id" = (
   ...>     SELECT "id"
   ...>     FROM "users"
   ...>     WHERE "username" = 'exceptionalinspiration482'
   ...> );
QUERY PLAN
`--COMPOUND QUERY
   |--LEFT-MOST SUBQUERY
   |  |--SEARCH friends USING COVERING INDEX sqlite_autoindex_friends_1 (user_id=?)
   |  `--SCALAR SUBQUERY 1
   |     `--SEARCH users USING COVERING INDEX sqlite_autoindex_users_1 (username=?)
   `--INTERSECT USING TEMP B-TREE
      |--SEARCH friends USING COVERING INDEX sqlite_autoindex_friends_1 (user_id=?)
      `--SCALAR SUBQUERY 3
         `--SEARCH users USING COVERING INDEX sqlite_autoindex_users_1 (username=?)
*/
