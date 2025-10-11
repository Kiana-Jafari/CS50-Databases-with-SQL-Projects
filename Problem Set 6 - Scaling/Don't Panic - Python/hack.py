from cs50 import SQL

db = SQL("sqlite:///dont-panic.db")
password = input("Enter your password: ")

db.execute(
    """
    UPDATE "users"
    SET "password" = ?
    WHERE "username" = 'admin'

    """, password
    );

________________________________________________________________________________

 # Alternative approach:

# Get the password from the user.
password = input("Enter your password: ")

# Import the sqlite3 package.
import sqlite3

# Make a connection to the SQLite3 server.
connection = sqlite3.connect("dont-panic.db")

# Create a cursor object: This is mainly for writing SQL queries.
cursor_obj = connection.cursor()

# Execute the code using the `.execute` method on the object.
cursor_obj.execute(
    """
    UPDATE "users"
    SET "password" = ?
    WHERE "username" = 'admin'

    """, [password]
)

# Use the `.commit` method so that the update persists.
connection.commit()

# Close the connection.
connection.close()
    
    
