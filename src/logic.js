export function formatTime(mins) {
  if (!mins) return "";
  if (mins < 60) return `${mins}m`;
  const h = Math.floor(mins / 60), m = mins % 60;
  return m ? `${h}h ${m}m` : `${h}h`;
}

export function difficultyLabel(d) {
  return { easy: "Easy", medium: "Medium", hard: "Hard" }[d] ?? d;
}

export function difficultyColor(d) {
  return { easy: "#059669", medium: "#d97706", hard: "#dc2626" }[d] ?? "#6b7280";
}

export function starDisplay(rating) {
  if (!rating) return "";
  return "★".repeat(rating) + "☆".repeat(5 - rating);
}

// Fields the in-app search matches against (see hub-sdk searchMatch). Category
// names are resolved by the caller (categoryMap lives in the view), so this
// stays pure. Replaces the old title-only filter — a recipe is now findable by
// an ingredient, a note, or its category, not just its name.
export function searchableFields(recipe, categoryNames = []) {
  return [recipe.title, recipe.description, recipe.ingredients_text, recipe.notes, ...categoryNames];
}

export function sortRecipes(list, sort) {
  const copy = [...list];
  if (sort === "rating") return copy.sort((a, b) => (b.rating ?? 0) - (a.rating ?? 0) || a.title.localeCompare(b.title));
  if (sort === "time")   return copy.sort((a, b) => (a.total_time_mins ?? 9999) - (b.total_time_mins ?? 9999) || a.title.localeCompare(b.title));
  return copy.sort((a, b) => a.title.localeCompare(b.title));
}

// A recipe save is ONE atomic write: the recipe row, the category clear on an
// edit, and one link per category. The cap keeps that well inside the hub's
// 25-statement batch (2 + 10 = 12 at most), so a save never spans batches.
export const MAX_RECIPE_CATEGORIES = 10;
export const CATEGORY_LIMIT_MESSAGE = `A recipe can have up to ${MAX_RECIPE_CATEGORIES} categories.`;

// `count` is how many categories are selected, the one being weighed included.
export function overCategoryLimit(count) {
  return count > MAX_RECIPE_CATEGORIES;
}

/**
 * The line a failed share-link create or revoke shows ("Hub endpoints other than `/api/db`"
 * in the app-template guide). The SDK's share helper puts the hub's `.status` on its error;
 * the hub's text never reaches the screen.
 *   402 — on a plain link, the free plan's active-link cap (a 402 for a password, sign-ups
 *         or a longer expiry is the caller's plan line, checked before this)
 *   409 — `code: "share_link_limit"` is a paid household's active-link cap; a 409 without
 *         that code (a failure inside the mint, or an older hub) keeps "try again"
 *   400 — `code: "password_too_short"`; the caller pre-checks the length, so this is a backstop
 *   403 — not allowed, including `code: "not_owner"` (revoking another member's link);
 *   404 — the item is gone (a revoke's 404 is the caller's: the link is already gone, or an
 *         older hub refusing a non-owner — the caller re-reads the list)
 */
export function shareFailureLine(e, { action, thing } = {}) {
  if (e?.status === 402) return "Too many share links are active — revoke one first.";
  if (e?.status === 409 && e?.code === "share_link_limit") return "Too many share links are active — revoke one first.";
  if (e?.status === 400 && e?.code === "password_too_short") return "The password needs at least 6 characters.";
  if (e?.status === 403) return `You don’t have permission to ${action}.`;
  if (e?.status === 404) return `This ${thing} has been removed.`;
  return `Couldn’t ${action} — try again.`;
}
