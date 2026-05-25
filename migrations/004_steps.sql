CREATE TABLE IF NOT EXISTS steps (
  household_id UUID NOT NULL DEFAULT current_setting('app.household_id', true)::uuid,
  id           TEXT NOT NULL,
  recipe_id    TEXT NOT NULL,
  instruction  TEXT NOT NULL,
  sort_order   INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (household_id, id)
);
