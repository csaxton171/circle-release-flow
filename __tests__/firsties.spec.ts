import { doTheThings } from "../src/firsties";

describe("firsties", () => {
  it.each`
    thing    | expected
    ${true}  | ${false}
    ${false} | ${true}
  `("does the things with '$thing'", ({ thing, expected }) => {
    expect(doTheThings(thing)).toBe(expected);
  });
});
