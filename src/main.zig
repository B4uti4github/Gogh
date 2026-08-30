const std = @import("std");

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();
    const res = initThorvg();
    if (res == 0) {
        try stdout.print("Thorvg init OK\n", .{});
        finishThorvg();
    } else {
        try stdout.print("Thorvg init FAILED (code: {d})\n", .{res});
    }
}
