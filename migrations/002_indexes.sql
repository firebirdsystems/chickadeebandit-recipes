CREATE INDEX IF NOT EXISTS idx_recipes_title       ON app_recipes__recipes(title);
CREATE INDEX IF NOT EXISTS idx_recipes_is_favorite ON app_recipes__recipes(is_favorite);
