const std = @import("std");

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

// TESTING: GENERIC VTABLE DYNAMICALLY DISPATCHED INTERFACE

fn WriterGeneric(T: type) type {
    return struct {
        ptr: *T,
        vtable: *const Vtable,

        pub const Vtable = struct {
            testing: *const fn (ptr: *WriterGeneric(T)) void,
        };

        pub fn testing(self: *WriterGeneric(T)) void {
            std.debug.print("{}\n", .{self});
        }
    };
}

const File2 = struct {
    id: i32,

    fn testing(self: *WriterGeneric(File2)) void {
        _ = self;
    }

    fn writerGeneric(self: *File2) WriterGeneric(File2) {
        return WriterGeneric(File2){
            .ptr = self,
            .vtable = &.{ .testing = testing },
        };
    }
};

pub fn main() !void {
    var file = File{ .id = 69 };
    try file.writer().writeAll("TESTING");
    try file.writer().vtable.writeAll(&file, "TESTING");
    var file2 = File2{ .id = 12 };
    var wg = file2.writerGeneric();
    wg.testing();
}
