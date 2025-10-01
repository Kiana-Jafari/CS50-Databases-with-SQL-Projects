-- Ingredients
    -- We certainly need to keep track of our ingredients. Some of the typical ingredients we use include flour, yeast, oil, butter, and several different types of sugar.
    -- Moreover, we would love to keep track of the price we pay per unit of ingredient (whether it’s pounds, grams, etc.).

CREATE TABLE ingredients (
    "id" INTEGER,
    "material" TEXT NOT NULL,
    "dollar_per_unit" REAL NOT NULL,
    PRIMARY KEY("id")
);


-- Donuts
    -- We’ll need to include our selection of donuts, past and present! For each donut on the menu, we’d love to include three things:
    -- The name of the donut
    -- Whether the donut is gluten-free
    -- The price per donut
-- Oh, and it’s important that we be able to look up the ingredients for each of the donuts!

CREATE TABLE donuts (
    "id" INTEGER,
    "name" TEXT NOT NULL,
    "gluten_free" INTEGER NOT NULL,
    "dollar_per_donut" REAL NOT NULL,
    PRIMARY KEY("id")
);


CREATE TABLE donut_ingredients (
    "ingredients_id" INTEGER,
    "donut_id" INTEGER,
    FOREIGN KEY("ingredients_id") REFERENCES ingredients("id"),
    FOREIGN KEY("donut_id") REFERENCES donuts("id")
);


-- Orders
    -- We love to see customers in person, though we realize a good number of people might order online nowadays.
    -- We’d love to be able to keep track of those online orders. We think we would need to store:
    -- An order number, to keep track of each order internally
    -- All the donuts in the order
    -- The customer who placed the order. We suppose we could assume only one customer places any given order.

CREATE TABLE orders (
    "id" INTEGER,
    "donut_id" INTEGER,
    "customer_id" INTEGER,
    "order_number" INTEGER NOT NULL,
    PRIMARY KEY("id"),
    FOREIGN KEY("donut_id") REFERENCES donuts("id"),
    FOREIGN KEY("customer_id") REFERENCES customers("id")
);


-- Customers
    -- Oh, and we realize it would be lovely to keep track of some information about each of our customers.
    -- We’d love to remember the history of the orders they’ve made. In that case, we think we should store:
    -- A customer’s first and last name
    -- A history of their orders

CREATE TABLE customers (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);


/*
Sample Data

Your database should be able to represent…

1. Cocoa, for which Union Square Donuts pays $5.00 for one pound.

INSERT INTO ingredients
VALUES (1, 'Cocoa', 5.00);

SELECT * FROM ingredients;
+----+----------+-----------------+
| id | material | dollar_per_unit |
+----+----------+-----------------+
| 1  | Cocoa    | 5.0             |
+----+----------+-----------------+

2. Sugar, for which Union Square Donuts pays $2.00 for one pound.

INSERT INTO ingredients
VALUES (2, 'Sugar', 2.00);

SELECT * FROM ingredients;
+----+----------+-----------------+
| id | material | dollar_per_unit |
+----+----------+-----------------+
| 1  | Cocoa    | 5.0             |
| 2  | Sugar    | 2.0             |
+----+----------+-----------------+

INSERT INTO ingredients
VALUES
    (3, 'Flour', 3.00),
    (4, 'Buttermilk', 2.00),
    (5, 'Sprinkles', 6.00)
;

Ingredients table:
+----+------------+-----------------+
| id |  material  | dollar_per_unit |
+----+------------+-----------------+
| 1  | Cocoa      | 5.0             |
| 2  | Sugar      | 2.0             |
| 3  | Flour      | 3.0             |
| 4  | Buttermilk | 2.0             |
| 5  | Sprinkles  | 6.0             |
+----+------------+-----------------+

3. Union Square Donuts’ “Belgian Dark Chocolate” donut, which is not gluten-free, costs $4.00, and includes the following ingredients:
    - Cocoa
    - Flour
    - Buttermilk
    - Sugar

INSERT INTO donuts
VALUES (1, 'Belgian Dark Chocolate', 0, 4.00);

SELECT * FROM donuts;
+----+------------------------+-------------+------------------+
| id |          name          | gluten_free | dollar_per_donut |
+----+------------------------+-------------+------------------+
| 1  | Belgian Dark Chocolate | 0           | 4.0              |
+----+------------------------+-------------+------------------+

INSERT INTO donut_ingredients
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 1);

SELECT * FROM donut_ingredients;
+----------------+----------+
| ingredients_id | donut_id |
+----------------+----------+
| 1              | 1        |
| 2              | 1        |
| 3              | 1        |
| 4              | 1        |
+----------------+----------+

4. Union Square Donuts’ “Back-To-School Sprinkles” donut, which is not gluten-free, costs $4.00, and includes the following ingredients:
    - Flour
    - Buttermilk
    - Sugar
    - Sprinkles

INSERT INTO donuts
VALUES (2, 'Back-To-School Sprinkles', 0, 4.00);

SELECT * FROM donuts;
+----+--------------------------+-------------+------------------+
| id |           name           | gluten_free | dollar_per_donut |
+----+--------------------------+-------------+------------------+
| 1  | Belgian Dark Chocolate   | 0           | 4.0              |
| 2  | Back-To-School Sprinkles | 0           | 4.0              |
+----+--------------------------+-------------+------------------+

INSERT INTO donut_ingredients
VALUES
    (2, 2),
    (3, 2),
    (4, 2),
    (5, 2);

SELECT * FROM donut_ingredients;
+----------------+----------+
| ingredients_id | donut_id |
+----------------+----------+
| 1              | 1        |
| 2              | 1        |
| 3              | 1        |
| 4              | 1        |
| 2              | 2        |
| 3              | 2        |
| 4              | 2        |
| 5              | 2        |
+----------------+----------+

5. Order 1 from Luis Singh for 3 Belgian Dark Chocolate donuts and 2 Back-To-School Sprinkles donuts.

INSERT INTO customers
VALUES (1, 'Luis', 'Singh');

SELECT * FROM customers;
+----+------------+-----------+
| id | first_name | last_name |
+----+------------+-----------+
| 1  | Luis       | Singh     |
+----+------------+-----------+

INSERT INTO orders
VALUES
    (1, 1, 1, 3),
    (2, 2, 1, 2);

SELECT * FROM orders;
+----+----------+-------------+--------------+
| id | donut_id | customer_id | order_number |
+----+----------+-------------+--------------+
| 1  | 1        | 1           | 3            |
| 2  | 2        | 1           | 2            |
+----+----------+-------------+--------------+
*/
