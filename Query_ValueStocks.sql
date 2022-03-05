WITH RECURSIVE pre1 AS (
  -- get the human readable year
  SELECT company, LEFT(fiscal_year::TEXT,4)::INT AS yr FROM dividend
), pre2 AS (
  SELECT pre1.company, pre1.yr, 1 AS cs 
   FROM pre1
  UNION DISTINCT
  -- add consecutives years
  SELECT pre1.company, pre1.yr, pre2.cs + 1 
   FROM pre1
   JOIN pre2 
     ON pre1.company = pre2.company
    AND pre1.yr = pre2.yr + 1
)
SELECT JSONB_AGG(DISTINCT company) FROM pre2
-- SELECT (DISTINCT company) FROM pre2
WHERE cs >= 3; 