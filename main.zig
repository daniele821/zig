const std = @import("std");
const aes = std.crypto.core.aes;

pub fn main() !void {
    const time = std.time.timestamp();
    const epoch_seconds = std.time.epoch.EpochSeconds{ .secs = @intCast(time) };
    const epoch_day = epoch_seconds.getEpochDay();
    const day_seconds = epoch_seconds.getDaySeconds();
    const year_day = epoch_day.calculateYearDay();
    const month = year_day.calculateMonthDay();
    const hours = day_seconds.getHoursIntoDay();
    const minutes = day_seconds.getMinutesIntoHour();
    const seconds = day_seconds.getSecondsIntoMinute();

    std.debug.print("{}\n{}\n{}\n{}\n", .{ epoch_seconds, epoch_day, day_seconds, year_day });
    std.debug.print("{}\n{}:{}:{}\n", .{ month, hours, minutes, seconds });
}
