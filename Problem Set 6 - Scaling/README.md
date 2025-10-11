# CS50 SQL Problem Set 6

Welcome to **Problem Set 6** of CS50’s *Introduction to Databases with SQL*!  
This set continues to broaden your database skills by moving into **server-grade schemas**, **distributed-system trade-offs**, and **automating database interactions** via Python. Each project highlights a different aspect of real-world data engineering and systems design.

---

## Projects Overview

### 1. Happy to Connect — `sentimental-connect`
Building on earlier social-network work, this project asks you to design a **MySQL** schema for a large-scale professional network (think LinkedIn). In `sentimental-connect/schema.sql`, you will create tables, types, indexes, and constraints appropriate for a production-grade MySQL deployment that can represent the provided sample data and meet the platform’s specification.

---

### 2. From the Deep
You are a researcher operating the **AquaByte Explorer**, a remote submarine that streams thousands of timestamped observations per minute to surface boats. In `answers.md`, analyze trade-offs across several possible **distributed database designs** for handling high-throughput, time-series-like observation data. Consider ingestion patterns, consistency, availability, partitioning, and cost when recommending architectures.

---

### 3. Don’t Panic! (automation)
A follow-up to the earlier pentesting exercise, this project brings automation into play. In `hack.py`, write a Python program that connects to a SQLite database and programmatically alters the administrator’s password.

---

## Technologies
- **MySQL** (schema design and server-grade types)  
- **SQLite** (lightweight local DB for scripting exercises)  
- **Python (sqlite3)** for programmatic database interaction  

---

## Notes
- The **Don’t Panic!** automation task is a simulated, controlled exercise to teach scripting and defensive thinking. Do **not** apply these techniques to systems you do not own or have explicit permission to test.  
