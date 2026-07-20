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
