SELECT
  id,
  title,
  difficulty,
  total_time_mins,
  rating,
  created_by_name,
  created_at
FROM app_recipes__recipes
WHERE is_favorite  = 1
ORDER BY (rating IS NULL), rating DESC, title
LIMIT 50
