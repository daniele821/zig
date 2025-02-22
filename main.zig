const std = @import("std");

pub fn main() !void {
    std.debug.print("testing: {s}\n", .{std.os.argv});
    const i: u8 = 250;
    std.debug.print("{}\n", .{@mulWithOverflow(i, i)});
}
