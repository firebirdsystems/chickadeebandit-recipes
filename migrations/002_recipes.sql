CREATE TABLE IF NOT EXISTS recipes (
  household_id    UUID NOT NULL DEFAULT current_setting('app.household_id', true)::uuid,
  id              TEXT NOT NULL,
  title           TEXT NOT NULL,
  description     TEXT NOT NULL DEFAULT '',
  category_id     TEXT,
  difficulty      TEXT NOT NULL DEFAULT 'medium',
  servings        INTEGER NOT NULL DEFAULT 4,
  total_time_mins INTEGER,
  source          TEXT NOT NULL DEFAULT '',
  rating          INTEGER,
  notes           TEXT NOT NULL DEFAULT '',
  created_by_id   TEXT NOT NULL,
  created_by_name TEXT NOT NULL,
  created_at      TEXT NOT NULL,
  updated_at      TEXT NOT NULL,
  PRIMARY KEY (household_id, id)
);
