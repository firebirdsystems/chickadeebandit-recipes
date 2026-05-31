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
  COALESCE(
    string_agg(c.name, ', ' ORDER BY c.name),
    ''
  ) AS categories
FROM recipes r
LEFT JOIN recipe_categories rc
  ON rc.recipe_id    = r.id
  AND rc.household_id = r.household_id
LEFT JOIN categories c
  ON c.id            = rc.category_id
  AND c.household_id = r.household_id
WHERE r.household_id = current_setting('app.household_id', true)::uuid
GROUP BY r.id, r.title, r.description, r.difficulty, r.servings,
         r.total_time_mins, r.rating, r.is_favorite,
         r.ingredients_text, r.created_by_name, r.created_at
ORDER BY r.is_favorite DESC, r.rating DESC NULLS LAST, r.title
LIMIT 200
