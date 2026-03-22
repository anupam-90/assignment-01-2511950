## Anomaly Analysis

1. **Insert Anomaly:** If the company hires a new Sales Representative (e.g., SR04, John Doe, john@corp.com, "New Office"), we cannot add them to `orders_flat.csv` until they make an actual sale, because doing so would leave the `order_id`, `customer_id`, and `product_id` fields empty/null, which breaks the structure of an order-tracking table.

2. **Update Anomaly:** If Priya Sharma (C002) changes her email address to `priya.new@gmail.com`, we must find and update every single row where she made a purchase (e.g., ORD1027, ORD1002, ORD1152). If we miss even one row, the data becomes inconsistent.

3. **Delete Anomaly:** If we delete the record for `ORD1120` (perhaps the order was cancelled), we accidentally lose all information about the product "Notebook" (P004) if that was the only order for it. We also lose the connection between Kavya Rao and that specific sales rep.

## Normalization Justification

While a single flat table seems simpler for a quick glance, it is highly problematic for an operational database (OLTP). Normalization is not over-engineering; it is essential for data integrity. 

Using the `orders_flat.csv` dataset as an example, customer Priya Sharma (C002) appears in multiple rows (ORD1027, ORD1002). If her address changes, a flat table requires updating multiple rows. If a system error occurs mid-update, half her orders will show the old address and half the new address. 

By normalizing to 3NF, we separate entities into distinct tables (`Customers`, `Products`, `SalesReps`, `Orders`). Priya's details exist in exactly one row in the `Customers` table. An update to her address happens once, instantaneously, and all her related orders automatically reference this updated data. Normalization saves storage space, prevents the insert/update/delete anomalies identified above, and ensures that our application has a single source of truth for every piece of data.
