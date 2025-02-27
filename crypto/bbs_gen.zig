const std = @import("std");

fn iterBbs(comptime T: type, n: T, x0: T) T {
    return (std.math.pow(T, x0, 2)) % n;
}

const SIZE = 1000;

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();

    var pseudoRandomness = std.ArrayList(u8).init(arena.allocator());

    const number = u64;
    const n = 83 * 107;
    var xi: number = 972;
    for (0..SIZE) |_| {
        xi = iterBbs(number, n, xi);
        try pseudoRandomness.append('0' + @as(u8, @truncate(xi & 1)));
    }
    std.debug.print("RESULT: {s}\n", .{pseudoRandomness.items});
}
