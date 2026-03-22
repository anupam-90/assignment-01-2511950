## ETL Decisions

### Decision 1 — Standardizing Date Formats
Problem: The raw `retail_transactions.csv` file had highly inconsistent date formats (e.g., "29/08/2023", "12-12-2023", "2023-02-05"). If left unchanged, querying for a specific month or sorting by date chronologically would fail in the database.
Resolution: During extraction, I parsed the varying strings into a standard ISO 8601 Date object (`YYYY-MM-DD`). I then generated an integer surrogate key (`YYYYMMDD`) for the `date_id` in the `dim_date` table to optimize join performance.

### Decision 2 — Categorical Casing Consistency
Problem: The `category` column had inconsistent casing (e.g., "electronics", "Electronics", "Grocery", "Groceries"). A SQL grouping query would treat "electronics" and "Electronics" as two separate departments, skewing the BI reports.
Resolution: I transformed the text data by applying a capitalization function and mapping synonyms (converting "Grocery" to "Groceries") so that `dim_product` only stores clean, unified category labels.

### Decision 3 — Pre-computing Total Revenue
Problem: The raw data provided `units_sold` and `unit_price`, but BI queries frequently need the total dollar amount of the transaction. Forcing the BI tool to calculate this on the fly for millions of rows is computationally expensive.
Resolution: I added a `total_revenue` column to the `fact_sales` table and calculated it during the ETL load phase (`units_sold * unit_price`). Storing this derived measure speeds up analytical queries significantly.
