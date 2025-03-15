const std = @import("std");
const c = @cImport(@cInclude("time.h"));

pub fn main() !void {
    // const input = "15/03/2025"; // Example date: 15th March 2025
    var tm: c.tm = undefined;

    // Parse the date manually (DD/MM/YYYY)
    const day: i32 = 12;
    const month: i32 = 13;
    const year: i32 = 2025;

    // _ = std.fmt.scan(input, "{d}/{d}/{d}", .{ &day, &month, &year }) catch {
    //     std.debug.print("Invalid date format!\n", .{});
    //     return;
    // };

    // Set up the `tm` struct
    tm.tm_mday = @intCast(day);
    tm.tm_mon = @intCast(month - 1); // tm_mon is 0-based (Jan = 0)
    tm.tm_year = @intCast(year - 1900); // tm_year is years since 1900
    tm.tm_hour = 0; // Assume midnight
    tm.tm_min = 0;
    tm.tm_sec = 0;
    tm.tm_isdst = -1; // Auto-detect Daylight Saving Time

    // Convert to Unix timestamp
    const unix_seconds: c.time_t = c.mktime(&tm);

    if (unix_seconds == -1) {
        std.debug.print("Failed to convert date to timestamp.\n", .{});
    } else {
        std.debug.print("Unix Timestamp: {d}\n", .{unix_seconds});
    }

    var rawtime: c.time_t = unix_seconds;
    var timeinfo: *c.tm = undefined;

    // Get the current time in Unix seconds
    // _ = c.time(&rawtime);

    // Convert to local time
    timeinfo = c.localtime(&rawtime);

    // Print year, month, day, hour, minute, second
    try std.io.getStdOut().writer().print("Year: {d}\nMonth: {d}\nDay: {d}\nHour: {d}\nMinute: {d}\nSecond: {d}\n", .{ timeinfo.*.tm_year + 1900, timeinfo.*.tm_mon + 1, timeinfo.*.tm_mday, timeinfo.*.tm_hour, timeinfo.*.tm_min, timeinfo.*.tm_sec });
}
