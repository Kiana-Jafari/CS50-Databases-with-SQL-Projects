# CS50’s Introduction to Databases with SQL – Problem Set 0  

This repository contains my solutions for **CS50’s Introduction to Databases with SQL – Problem Set 0**, which includes three projects: **Cyberchase**, **36 Views**, and **Players**. Each project explores SQL fundamentals by querying and analyzing real-world inspired datasets.  

---

## Projects Overview  

### 1. Cyberchase  
- **Database:** `cyberchase.db`  
- **Table:** `episodes`  
- **Description:**  
  Based on PBS’s animated educational series *Cyberchase*, this project explores data on episodes aired since 2002. Using SQL, the queries answer PBS’s questions about episode history, release dates, and trends in the show.  

---

### 2. 36 Views  
- **Database:** `views.db`  
- **Tables:** Prints created by **Katsushika Hokusai** and **Utagawa Hiroshige**  
- **Description:**  
  This project analyzes 72 famous Japanese woodblock prints, including *The Great Wave off Kanagawa* and *Fine Wind, Clear Morning*. The dataset includes not only titles and authors but also computational image analysis statistics such as:  
  - Average color  
  - Brightness  
  - Contrast  
  - Entropy  
  SQL queries were written to uncover numeric insights about these artworks beyond their aesthetic appeal.  

---

### 3. Players  
- **Database:** `players.db`  
- **Table:** `players`  
- **Description:**  
  Using MLB (Major League Baseball) data from **1871 to 2023**, this project queries historical information about professional players. Questions explore player careers, performance, and long-term trends in baseball history.  

---

## Tech Stack  
- **Language:** SQL  
- **Tools:** SQLite3 
- **Course:** [CS50’s Introduction to Databases with SQL](https://cs50.harvard.edu/sql/)  

---

## Getting Started  

1. Clone this repository:  
   ```bash
   git clone https://github.com/Kiana-Jafari/cs50-sql-pset0.git
   cd cs50-sql-pset0
   ```  

2. Open the database file in SQLite:  
   ```bash
   sqlite3 cyberchase.db
   sqlite3 views.db
   sqlite3 players.db
   ```  

3. Run the queries stored in the respective `.sql` files to explore the data.  

---

## Acknowledgements  
- Problem sets and databases provided by **CS50’s Introduction to Databases with SQL**.  
- Data and context from PBS, Japanese art history, and MLB records were used as the basis for the assignments.  
