# Medium Stats — DESIGN.md

---

## 1. Purpose

The database stores article-level metrics exported from Medium (or a Medium-like dataset). The goal is to support analytical queries that identify what drives engagement (claps and responses), compare publication performance, and generate actionable recommendations (best posting months, optimal reading time, high-performing publications/titles/tags). The dataset is intended primarily for read-only analytics (aggregations, rankings).

## 2. Scope

- Input: CSV export of articles with metadata and engagement metrics.
- Core outputs:
  - Publication-level performance summaries
  - Monthly trends and seasonality of engagement
  - Optimal reading-time analysis
  - Top-performing titles and outlier detection
  - A small set of derived metrics (engagement score, read\_flag)
- The project focuses on SQL features: aggregation, views, indexes, and generated columns (if available).

## 3. Entities & Attributes

Below are the main entities and the recommended fields/types (SQLite affinities):

### `medium_data` (existing single-table import)

- `id` INTEGER PRIMARY KEY AUTOINCREMENT — unique article id
- `url` TEXT — article link
- `title` TEXT
- `subtitle` TEXT NULLABLE
- `claps` INTEGER NOT NULL DEFAULT 0
- `responses` INTEGER NULLABLE  -- converted to NULL where non-numeric (e.g., 'Read')
- `reading_time` INTEGER NOT NULL  -- minutes
- `publication` TEXT NOT NULL CHECK(publication IN (...))  -- limited set in original file
- `date` DATE NOT NULL  -- ISO `YYYY-MM-DD`
- `engagement_score` REAL NULLABLE  -- derived: weighted metric

> Note: For full normalization you could split `publication` into a separate table, but for this dataset size and analytics focus, a single-table design is acceptable.

## 4. Relationships

This dataset is currently *single-table* (article-centric). Typical relationships if expanded:

- `publication` (1) → `medium_data` (many)
- `author` (1) → `medium_data` (many) — if author metadata added
- `tags` many-to-many with `medium_data` through `article_tags` — optional extension for tag-based analysis

ER diagram (ASCII):

```
+-------------+      1     +-------------+     M      +-------------+
| publication |<------------| medium_data |---------->| article_tags |
+-------------+            +-------------+           +-------------+
| id          |            | id          |           | id          |
| name        |            | title       |           | article_id  |
+-------------+            | url         |           | tag_name    |
                           | claps       |           +-------------+
                           | responses   |
                           | reading_time|
                           | date        |
                           | engagement_score |
                           | is_discussion     |
                           +-------------+
```

## 5. Derived Columns and Transforms

Suggested derived fields (compute once, store, or defined as generated columns when SQLite supports it):

- `engagement_score` — weighted combination of claps and responses. Recommended default: `0.8 * claps + 0.2 * responses`. Optionally divide by `reading_time` for per-minute rate.
- Suggested: `month` — `strftime('%Y-%m', date)` for monthly grouping (use views or computed column).

## 6. Indexes & Performance Optimizations

Given the analytic workload, create this index:

- `CREATE INDEX story_title ON medium_data(title, responses, claps);` — speeds queries relevant to finding the title of the story based on the number of claps and responses.

Other optimizations:

- Use **views** for frequently used aggregations (e.g., `monthly_summary`, `publication_summary`).
- Keep raw columns (`claps`, `responses`) so you can recompute metrics with different transforms/weights.

## 7. SQL Features to Demonstrate (Checklist)

- **Schema creation** and import statement (already present in `medium.sql`).
- **Data cleaning steps** (trim publication, convert 'Read' to NULL).
- **Aggregations & GROUP BY**: avg, max, count per publication and month.
- **Views**: `monthly_summary`
- **Indexes** and `EXPLAIN QUERY PLAN` examples (already included in `medium.sql`).

## 8. Example Analyses (what to include in final report)

- Publication ranking by average `engagement_score`.
- Monthly trend plot (avg engagement per month) and commentary on seasonality (January spike).
- Discussion vs. regular articles.

## 9. Limitations & Known Data Issues

- `responses` originally contains a couple of non-numeric values (`'Read'`), which are not counts. We flag these and convert to NULL for numeric aggregations.
- No `views` or `followers` metrics — so engagement is proxy-only (claps & responses). This limits conclusions about reach vs. conversion.
- No author info, tags, or explicit publish time-of-day (only date), which limits recommendations about timing and tag effectiveness.
- Dataset is a snapshot (2019 mainly) — results may be time-specific and not generalize.

## 10. Deliverables & File Structure

```
project-root/
├─ DESIGN.md            <-- this document
├─ medium.sql           <-- schema + import + cleaning + queries (provided)
├─ data.csv             <-- the main data
├─ ER-diagram.png       <-- optional visual ER diagram
```
