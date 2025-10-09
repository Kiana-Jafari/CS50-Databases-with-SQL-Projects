/*
Users need to be prevented from re-opening a message that has expired.
Find when the message with ID 151 expires. You may use the message’s ID directly in your query.
Ensure your query uses the index automatically created on the primary key column of the `messages` table.
*/

SELECT "expires_timestamp"
FROM "messages"
WHERE "id" = 151;

/*
+---------------------+
|  expires_timestamp  |
+---------------------+
| 2021-10-04 13:20:12 |
+---------------------+
*/

/*
EXPLAIN QUERY PLAN
   ...> SELECT "expires_timestamp"
   ...> FROM "messages"
   ...> WHERE "id" = 151;
   
QUERY PLAN
`--SEARCH messages USING INTEGER PRIMARY KEY (rowid=?)
*/
