const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "hello",
        .root_source_file = b.path("src/main.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });

    const zigaes = b.dependency("zigaes", .{}).module("zigaes");
    exe.root_module.addImport("zigaes", zigaes);
    const zeit = b.dependency("zeit", .{}).module("zeit");
    exe.root_module.addImport("zeit", zeit);
    const zdt = b.dependency("zdt", .{}).module("zdt");
    exe.root_module.addImport("zdt", zdt);
    exe.linkSystemLibrary("c");
    b.installArtifact(exe);
    const run_exe = b.addRunArtifact(exe);

    // run step
    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);

    // test step
    const test_step = b.step("test", "Run all the tests");
    const tests = b.addTest(.{ .root_source_file = b.path("./src/tests.zig") });
    test_step.dependOn(&b.addRunArtifact(tests).step);
}
