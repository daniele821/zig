const std = @import("std");
const c = @cImport({
    @cInclude("time.h");
});

pub fn main() !void {
    var rawtime: c.time_t = undefined;
    var timeinfo: *c.tm = undefined;
    var buffer: [20]u8 = undefined;

    // Get the current time in Unix seconds
    _ = c.time(&rawtime);

    // Convert to local time
    timeinfo = c.localtime(&rawtime);

    // Format the time as "dd/mm/yy hh:mm:ss"
    _ = c.strftime(&buffer, buffer.len, "%d/%m/%y %H:%M:%S", timeinfo);

    // Print the formatted time
    try std.io.getStdOut().writer().print("Formatted Time: {s}\n", .{buffer});
}
