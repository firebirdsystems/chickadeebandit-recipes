CREATE TABLE IF NOT EXISTS ingredients (
  household_id UUID NOT NULL DEFAULT current_setting('app.household_id', true)::uuid,
  id           TEXT NOT NULL,
  recipe_id    TEXT NOT NULL,
  name         TEXT NOT NULL,
  amount       TEXT NOT NULL DEFAULT '',
  unit         TEXT NOT NULL DEFAULT '',
  sort_order   INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (household_id, id)
);
