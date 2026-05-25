CREATE TABLE IF NOT EXISTS categories (
  household_id UUID NOT NULL DEFAULT current_setting('app.household_id', true)::uuid,
  id           TEXT NOT NULL,
  name         TEXT NOT NULL,
  color        TEXT NOT NULL DEFAULT '#6b7280',
  created_at   TEXT NOT NULL,
  PRIMARY KEY (household_id, id)
);

CREATE TABLE IF NOT EXISTS recipes (
  household_id      UUID NOT NULL DEFAULT current_setting('app.household_id', true)::uuid,
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
  PRIMARY KEY (household_id, id)
);

CREATE TABLE IF NOT EXISTS recipe_categories (
  household_id UUID NOT NULL DEFAULT current_setting('app.household_id', true)::uuid,
  recipe_id    TEXT NOT NULL,
  category_id  TEXT NOT NULL,
  PRIMARY KEY (household_id, recipe_id, category_id)
);


