import { plumbus } from "../src/plumbus";
describe("plumbus", () => {
  it("should do the things", () => {
    expect(plumbus("a", "b", 12, "c")).toEqual({
      isPlumbus: true,
      dinglebup: "a",
      shleem: "b",
      grumbo: 12,
      fleeb: "c"
    });
  });
});
