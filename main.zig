const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    // Command to run
    const argv = [_][]const u8{ "ls", "-l" };

    // Spawn the child process
    var child = std.process.Child.init(argv[0..], allocator);

    // Capture stdout and stderr
    child.stdout_behavior = .Pipe;
    child.stderr_behavior = .Pipe;

    try child.spawn();

    // Read the output
    const stdout = try child.stdout.?.reader().readAllAlloc(allocator, std.math.maxInt(usize));
    defer allocator.free(stdout);

    const stderr = try child.stderr.?.reader().readAllAlloc(allocator, std.math.maxInt(usize));
    defer allocator.free(stderr);

    // Wait for the child process to finish
    const term = try child.wait();

    // Check the exit status
    switch (term) {
        .Exited => |code| {
            if (code != 0) {
                std.debug.print("Command failed with exit code {}\n", .{code});
                std.debug.print("Stderr: {s}\n", .{stderr});
                return error.CommandFailed;
            }
        },
        else => {
            std.debug.print("Command terminated abnormally\n", .{});
            return error.CommandFailed;
        },
    }

    // Print the output
    std.debug.print("Stdout: {s}\n", .{stdout});
}
