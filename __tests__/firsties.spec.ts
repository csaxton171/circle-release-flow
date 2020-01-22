describe("assert", () => {
  it("should support defined assertions", () => {
    expect({}).toBeDefined();
    expect(undefined).toBeUndefined();
  });
});
