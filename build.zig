const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "hello",
        .root_source_file = b.path("src/main.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });

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
