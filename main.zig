const std = @import("std");

pub fn main() !void {
    std.debug.print("testing: {s}", .{std.os.argv});
}
