import { describe, it, expect } from "vitest";
import { formatTime, difficultyLabel, difficultyColor, starDisplay, sortRecipes } from "../src/logic.js";

describe("formatTime", () => {
  it("returns '' for zero/missing minutes", () => {
    expect(formatTime(0)).toBe("");
    expect(formatTime(null)).toBe("");
    expect(formatTime(undefined)).toBe("");
  });

  it("formats sub-hour, exact-hour, and mixed durations", () => {
    expect(formatTime(45)).toBe("45m");
    expect(formatTime(60)).toBe("1h");
    expect(formatTime(90)).toBe("1h 30m");
    expect(formatTime(120)).toBe("2h");
  });
});

describe("difficultyLabel / difficultyColor", () => {
  it("maps known difficulties", () => {
    expect(difficultyLabel("easy")).toBe("Easy");
    expect(difficultyColor("hard")).toBe("#dc2626");
  });

  it("falls back for unknown values", () => {
    expect(difficultyLabel("expert")).toBe("expert");
    expect(difficultyColor("expert")).toBe("#6b7280");
  });
});

describe("starDisplay", () => {
  it("returns '' when unrated", () => {
    expect(starDisplay(0)).toBe("");
    expect(starDisplay(null)).toBe("");
  });

  it("renders filled and empty stars out of five", () => {
    expect(starDisplay(3)).toBe("★★★☆☆");
    expect(starDisplay(5)).toBe("★★★★★");
  });
});

describe("sortRecipes", () => {
  const list = [
    { title: "Bread", rating: 3, total_time_mins: 180 },
    { title: "Apple pie", rating: 5, total_time_mins: 90 },
    { title: "Curry", rating: null, total_time_mins: null },
    { title: "Dumplings", rating: 5, total_time_mins: 60 },
  ];

  it("does not mutate the input", () => {
    const copy = [...list];
    sortRecipes(list, "rating");
    expect(list).toEqual(copy);
  });

  it("sorts by rating desc, title asc as tiebreak, missing rating last", () => {
    expect(sortRecipes(list, "rating").map((r) => r.title)).toEqual(["Apple pie", "Dumplings", "Bread", "Curry"]);
  });

  it("sorts by time asc with missing times last", () => {
    expect(sortRecipes(list, "time").map((r) => r.title)).toEqual(["Dumplings", "Apple pie", "Bread", "Curry"]);
  });

  it("defaults to title order", () => {
    expect(sortRecipes(list, "title").map((r) => r.title)).toEqual(["Apple pie", "Bread", "Curry", "Dumplings"]);
  });
});
