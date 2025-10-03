# CS50 SQL Problem Set 3

Welcome to **Problem Set 3** of CS50’s Introduction to Databases with SQL!  
This set focuses on **data manipulation, import/cleanup**, and — in one exercise — thinking about how systems can be misused (so you also practice defensive thinking and ethics).

---

## Projects Overview

### 1. Don’t Panic!
A trained **penetration tester (pentester)** is hired to audit a small enterprise’s SQLite database that powers their website. The exercise simulates a covert operation where you must:

- **Alter** the password of the site’s administrative account.  
- **Erase** any database logs that record the password change.  
- **Insert false data** to obfuscate your actions and throw investigators off the trail.

> ⚠️ **Ethics note:** This project is a simulated, controlled exercise intended to teach database manipulation, logging, and the importance of secure data practices. Do **not** apply these techniques to systems you do not own or have explicit, legal permission to test.

---

### 2. Meteorite Cleaning
As a data engineer at **NASA**, you’re responsible for importing and cleaning a CSV of historical meteorite landings into a SQLite database. Your job is to:

- **Import** the raw CSV into SQLite.  
- **Clean and normalize** fields (dates, numeric types, location coordinates, missing values).  
- **Design tables** appropriate for future analysis by engineers and scientists.  
- Produce a final, well-structured `meteorites.db` ready for analytical queries.
- 
---

## Technologies
- **SQLite** (primary engine)  
- SQL scripts for data manipulation and cleaning  
- CSV import tools or `sqlite3` `.import` workflows  
- Documentation/comments on ethical considerations and safe testing practices

---

## Notes
- The **Don’t Panic!** exercise is for learning defensive and offensive perspectives; always operate within legal and ethical boundaries.  
