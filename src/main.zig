const std = @import("std");
const zeit = @import("zeit");

const Writer = struct {
    ptr: *anyopaque,
    vtable: *const Vtable,

    pub const Vtable = struct {
        writeAll: *const fn (ptr: *anyopaque, data: []const u8) anyerror!void,
    };

    fn writeAll(self: Writer, data: []const u8) !void {
        return self.vtable.writeAll(self.ptr, data);
    }
};

const File = struct {
    id: i32,

    fn writeAll(ptr: *anyopaque, data: []const u8) !void {
        const self: *File = @ptrCast(@alignCast(ptr));
        std.debug.print("{}|{s}\n", .{ self, data });
    }

    fn writer(self: *File) Writer {
        return .{
            .ptr = self,
            .vtable = &Writer.Vtable{
                .writeAll = writeAll,
            },
        };
    }
};
pub fn main() !void {
    var file = File{ .id = 69 };
    try file.writer().writeAll("TESTING");
    try file.writer().vtable.writeAll(&file, "TESTING");
}
