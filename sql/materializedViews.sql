DROP MATERIALIZED VIEW IF EXISTS "mat_email_seasonBD" 
CREATE MATERIALIZED VIEW "mat_email_seasonBD" AS (
  SELECT (
    CASE extract("month" FROM "birthday")
    WHEN 1 THEN 'winter'
    WHEN 2 THEN 'winter'
    WHEN 3 THEN 'spring'
    WHEN 4 THEN 'spring'
    WHEN 5 THEN 'spring'
    WHEN 6 THEN 'summer'
    WHEN 7 THEN 'summer'
    END
  ) AS "season", "birthday","email"
  FROM "users"
) 

SELECT * FROM "mat_email_seasonBD"