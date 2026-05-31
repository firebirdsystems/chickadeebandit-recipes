SELECT
  id,
  title,
  difficulty,
  total_time_mins,
  rating,
  created_by_name,
  created_at
FROM recipes
WHERE household_id = current_setting('app.household_id', true)::uuid
  AND is_favorite  = 1
ORDER BY rating DESC NULLS LAST, title
LIMIT 50
