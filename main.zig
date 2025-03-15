const std = @import("std");
const aes = std.crypto.core.aes;

pub fn main() !void {
    const time = std.time.timestamp();
    std.debug.print("{}\n", .{time});
}

// fn testEpoch(secs: u64, expected_year_day: YearAndDay, expected_month_day: MonthAndDay, expected_day_seconds: struct {
//     /// 0 to 23
//     hours_into_day: u5,
//     /// 0 to 59
//     minutes_into_hour: u6,
//     /// 0 to 59
//     seconds_into_minute: u6,
// }) !void {
//     const epoch_seconds = EpochSeconds{ .secs = secs };
//     const epoch_day = epoch_seconds.getEpochDay();
//     const day_seconds = epoch_seconds.getDaySeconds();
//     const year_day = epoch_day.calculateYearDay();
//     try testing.expectEqual(expected_year_day, year_day);
//     try testing.expectEqual(expected_month_day, year_day.calculateMonthDay());
//     try testing.expectEqual(expected_day_seconds.hours_into_day, day_seconds.getHoursIntoDay());
//     try testing.expectEqual(expected_day_seconds.minutes_into_hour, day_seconds.getMinutesIntoHour());
//     try testing.expectEqual(expected_day_seconds.seconds_into_minute, day_seconds.getSecondsIntoMinute());
// }
//
// test "epoch decoding" {
//     try testEpoch(0, .{ .year = 1970, .day = 0 }, .{
//         .month = .jan,
//         .day_index = 0,
//     }, .{ .hours_into_day = 0, .minutes_into_hour = 0, .seconds_into_minute = 0 });
//
//     try testEpoch(31535999, .{ .year = 1970, .day = 364 }, .{
//         .month = .dec,
//         .day_index = 30,
//     }, .{ .hours_into_day = 23, .minutes_into_hour = 59, .seconds_into_minute = 59 });
//
//     try testEpoch(1622924906, .{ .year = 2021, .day = 31 + 28 + 31 + 30 + 31 + 4 }, .{
//         .month = .jun,
//         .day_index = 4,
//     }, .{ .hours_into_day = 20, .minutes_into_hour = 28, .seconds_into_minute = 26 });
//
//     try testEpoch(1625159473, .{ .year = 2021, .day = 31 + 28 + 31 + 30 + 31 + 30 }, .{
//         .month = .jul,
//         .day_index = 0,
//     }, .{ .hours_into_day = 17, .minutes_into_hour = 11, .seconds_into_minute = 13 });
// }
//
