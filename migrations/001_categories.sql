CREATE TABLE IF NOT EXISTS categories (
  household_id UUID NOT NULL DEFAULT current_setting('app.household_id', true)::uuid,
  id           TEXT NOT NULL,
  name         TEXT NOT NULL,
  color        TEXT NOT NULL DEFAULT '#6b7280',
  created_at   TEXT NOT NULL,
  PRIMARY KEY (household_id, id)
);
