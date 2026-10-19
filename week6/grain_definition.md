# definition of grain 
---Dr. Heather Wegwerth
---CST 335 100 Data Management & Big Data Systems
---Jeffrey Yabandith

This grain is at the lowest level of detail possible, so that every analytical question can be answered through rolling the rows up instead of breaking them apart from eachother. Because each of the rows are a single loan, counting or summing the `loan_count` gives the total loans, and also by averaging `loan_duration_days` it gives an accurate average loan length. Each row is linking to exactly one date, one item, and one campus, so that the same facts can be grouped by the month, semester, year, item category, or campus without any double counting.
