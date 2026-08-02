-- Automation support for the `add_recipe` action.
--
-- `source_event_id` records which app event produced the row. The dispatcher's
-- dedupe guard matches on it (SELECT 1 FROM ... WHERE source_event_id = ?
-- LIMIT 1), so a retried or replayed delivery finds the existing recipe and
-- skips instead of writing a second copy of it.
--
-- Nullable on purpose: a recipe typed into the form has no source event, and
-- the guard only ever looks for a specific non-null id.
ALTER TABLE app_recipes__recipes ADD COLUMN source_event_id TEXT;

CREATE INDEX IF NOT EXISTS app_recipes__idx_recipes_source_event_id
  ON app_recipes__recipes(source_event_id);
