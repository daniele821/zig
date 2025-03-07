const std = @import("std");

pub fn main() !void {}

test "json parse" {
    const Place = struct { lat: f32, long: f32 };
    const parsed = try std.json.parseFromSlice(
        Place,
        std.testing.allocator,
        \\{ "lat": 40.684540, "long": -74.401422 }
    ,
        .{},
    );
    defer parsed.deinit();

    const place = parsed.value;

    try std.testing.expect(place.lat == 40.684540);
    try std.testing.expect(place.long == -74.401422);
}
