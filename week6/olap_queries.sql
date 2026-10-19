---Dr. Heather Wegwerth
---CST 335 100 Data Management & Big Data Systems
---Jeffrey Yabandith

-- query #1: the total loans by the month and item category
-- OLAP: the aggregation across two dimensions (date and item), much like a pivot table.
SELECT d.year, d.month, i.item_category, SUM(f.loan_count) AS total_loans
FROM fact_loans f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_item i ON f.item_key = i.item_key
GROUP BY d.year, d.month, i.item_category
ORDER BY d.year, d.month, i.item_category;

-- query #2: the average loan duration by campus
-- OLAP: the aggregation of a measure grouped by a single dimension.
SELECT c.campus_name, ROUND(AVG(f.loan_duration_days), 1) AS avg_duration_days
FROM fact_loans f
JOIN dim_campus c ON f.campus_key = c.campus_key
GROUP BY c.campus_name
ORDER BY avg_duration_days DESC;

-- query #3: the top 3 item categories by the annual usage
-- OLAP: the aggregation by the year and category, then ranking them within each year.
SELECT year, item_category, total_loans
FROM (
    SELECT d.year, i.item_category, SUM(f.loan_count) AS total_loans,
           RANK() OVER (PARTITION BY d.year ORDER BY SUM(f.loan_count) DESC) AS rnk
    FROM fact_loans f
    JOIN dim_date d ON f.date_key = d.date_key
    JOIN dim_item i ON f.item_key = i.item_key
    GROUP BY d.year, i.item_category
) t
WHERE rnk <= 3
ORDER BY year, rnk;

-- query #4: the loans by each semester and campus
-- OLAP: dicing each cube by the two dimensions (semester and campus).
SELECT d.semester, c.campus_name, SUM(f.loan_count) AS total_loans
FROM fact_loans f
JOIN dim_date d ON f.date_key = d.date_key
JOIN dim_campus c ON f.campus_key = c.campus_key
GROUP BY d.semester, c.campus_name
ORDER BY d.semester, c.campus_name;

-- query #5: the count of overdue vs. the returned-on-time loans
-- OLAP: the aggregation when grouped by a status flag.
SELECT CASE WHEN is_overdue = 1 THEN 'Overdue' ELSE 'Returned on time' END AS loan_status,
       COUNT(*) AS loan_count
FROM fact_loans
GROUP BY loan_status
ORDER BY loan_status;

