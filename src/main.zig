const std = @import("std");

const PowerIterator = struct {
    current: u64 = 1,
    limit: u64 = 1_000_000,
    step: u64 = 2,

    fn next(self: *PowerIterator) ?u64 {
        self.current *= self.step;
        if (self.current > self.limit) {
            return null;
        }
        return self.current;
    }
};

pub fn main() !void {
    const values = [_]u64{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 };
    for (values) |index| {
        std.debug.print("{:>2}: ", .{index});
        const euler_number = euler(index, true);
        std.debug.print(" | {}\n", .{euler_number});
    }
}

fn euler(x: u64, print: bool) u64 {
    var count: u64 = 0;
    for (1..@max(1, x)) |i| {
        if (gcd(i, x) == 1) {
            if (print) std.debug.print("{},", .{i});
            count += 1;
        }
    }
    return @max(1, count);
}

fn gcd(x: u64, y: u64) u64 {
    if (x == 1 or y == 1) return 1;
    if (x == 0) return y;
    if (y == 0) return x;
    return gcd(y, x % y);
}
