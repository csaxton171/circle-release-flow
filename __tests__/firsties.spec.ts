import { doTheThings, doMoreThings } from "../src/firsties";

describe("firsties", () => {
  it.each`
    thing    | expected
    ${true}  | ${false}
    ${false} | ${true}
  `("does the things with '$thing'", ({ thing, expected }) => {
    expect(doTheThings(thing)).toBe(expected);
  });

  it.each`
    thingsCount | expected
    ${1}        | ${1}
    ${22}       | ${22}
  `(
    "does the more of the things with '$thingsCount'",
    ({ thingsCount, expected }) => {
      expect(doMoreThings(thingsCount)).toBe(expected);
    }
  );
});
