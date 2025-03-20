const std = @import("std");
const zeit = @import("zeit");

// TAGGED ENUM DYNAMIC DISPATCH (limits allowed implementations + requires extra space to choose)
const Animal = union(enum) {
    cat: Cat,
    dog: Dog,

    pub fn talk(self: Animal) void {
        switch (self) {
            inline else => |case| case.talk(),
        }
    }
};
const Cat = struct {
    anger_level: usize,

    pub fn talk(self: Cat) void {
        std.debug.print("Cat: meow! (anger lvl {})", .{self.anger_level});
    }
};

const Dog = struct {
    name: []const u8,

    pub fn talk(self: Dog) void {
        std.debug.print("{s} the dog: bark!", .{self.name});
    }
};

// VTABLE DYNAMIC DYSPATCH
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
