CREATE TABLE IF NOT EXISTS app_recipes__categories (
  id           TEXT NOT NULL,
  name         TEXT NOT NULL,
  color        TEXT NOT NULL DEFAULT '#6b7280',
  created_at   TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS app_recipes__recipes (
  id                TEXT NOT NULL,
  title             TEXT NOT NULL,
  description       TEXT NOT NULL DEFAULT '',
  steps_text        TEXT NOT NULL DEFAULT '',
  ingredients_text  TEXT NOT NULL DEFAULT '',
  difficulty        TEXT NOT NULL DEFAULT 'medium',
  servings          INTEGER NOT NULL DEFAULT 4,
  total_time_mins   INTEGER,
  source            TEXT NOT NULL DEFAULT '',
  rating            INTEGER,
  notes             TEXT NOT NULL DEFAULT '',
  is_favorite       INTEGER NOT NULL DEFAULT 0,
  created_by_id     TEXT NOT NULL,
  created_by_name   TEXT NOT NULL,
  created_at        TEXT NOT NULL,
  updated_at        TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS app_recipes__recipe_categories (
  recipe_id    TEXT NOT NULL,
  category_id  TEXT NOT NULL,
  PRIMARY KEY (recipe_id, category_id)
);


