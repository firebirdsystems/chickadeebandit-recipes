SELECT
  r.id,
  r.title,
  r.description,
  r.difficulty,
  r.servings,
  r.total_time_mins,
  r.rating,
  r.is_favorite,
  r.ingredients_text,
  r.created_by_name,
  r.created_at,
  COALESCE(GROUP_CONCAT(c.name, ', '), '') AS categories
FROM app_recipes__recipes r
LEFT JOIN app_recipes__recipe_categories rc
  ON rc.recipe_id    = r.id
LEFT JOIN app_recipes__categories c
  ON c.id            = rc.category_id
GROUP BY r.id, r.title, r.description, r.difficulty, r.servings,
         r.total_time_mins, r.rating, r.is_favorite,
         r.ingredients_text, r.created_by_name, r.created_at
ORDER BY r.is_favorite DESC, (r.rating IS NULL), r.rating DESC, r.title
LIMIT 200
