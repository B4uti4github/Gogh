const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Zig 0.11-compatible minimal build.zig
    // Use the std helper to obtain release options (works in Zig 0.11).
    const mode = std.build.standardReleaseOptions(b);

    const exe = b.addExecutable("gogh", "src/main.zig");
    exe.setBuildMode(mode);

    const fs = std.fs;
    const cwd = fs.cwd();

    // Add C wrapper if it exists (try common locations)
    const wrapper_candidates = [_][]const u8{ "src/bindings/thorvg_c_wrapper.c", "src/wrapper.c" };
    var found_wrapper: bool = false;
    for (wrapper_candidates) |p| {
        if (cwd.stat(p)) |meta| {
            _ = meta; // discard metadata
            exe.addCSourceFile(p, &.{});
            found_wrapper = true;
            break;
        } else |err| {
            if (err != fs.File.Error.FileNotFound) std.debug.warn("warning: stat('{s}') error: {any}\n", .{p, err});
        }
    }
    if (!found_wrapper) std.debug.warn("No C wrapper found; continuing without it.\n", .{});

    // Include Thorvg headers if present
    const thorvg_include = "third_party/thorvg/include";
    if (cwd.stat(thorvg_include)) |meta2| {
        _ = meta2;
        exe.includeDirs += .{ thorvg_include };
    } else |err| {
        if (err != fs.File.Error.FileNotFound) std.debug.warn("warning: stat('{s}') error: {any}\n", .{thorvg_include, err});
    }

    // Attempt to link with system library "thorvg"; if not available, linking will fail later.
    exe.linkSystemLibrary("thorvg");

    exe.install();
}
