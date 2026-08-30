const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Prefer the std helper when available (Zig 0.11+). If not available,
    // fall back to a reasonable Mode. This file is intended to be robust
    // across several Zig stdlib versions used in CI.
    var mode: std.build.Mode = undefined;
    comptime {
        if (@hasDecl(std.build, "standardReleaseOptions")) {
            mode = std.build.standardReleaseOptions(b);
        } else if (@hasDecl(@TypeOf(b.*), "standardReleaseOptions")) {
            mode = b.standardReleaseOptions();
        } else {
            // Fallback to a concrete mode if helper is not present
            if (@hasDecl(std.build, "Mode") and @hasDecl(std.build.Mode, "ReleaseSafe")) {
                mode = std.build.Mode.ReleaseSafe;
            } else if (@hasDecl(std.build, "Mode") and @hasDecl(std.build.Mode, "ReleaseFast")) {
                mode = std.build.Mode.ReleaseFast;
            } else {
                mode = std.build.Mode.Debug;
            }
        }
    }

    const exe = b.addExecutable("gogh", "src/main.zig");
    exe.setBuildMode(mode);

    const fs = std.fs;
    const cwd = fs.cwd();

    // Try several possible wrapper paths and only add the first that exists.
    const wrapper_candidates = [_][]const u8{
        "src/bindings/thorvg_c_wrapper.c",
        "src/wrapper.c",
    };

    var found_wrapper = false;
    for (wrapper_candidates) |p| {
        const stat_res = cwd.stat(p);
        if (stat_res) | _ | {
            exe.addCSourceFile(p, &.{});
            found_wrapper = true;
            break;
        } else |err| {
            // If the file is simply not found, continue silently.
            if (err != fs.File.Error.FileNotFound) {
                std.debug.warn("warning: stat('{s}') returned error: {any}\n", .{p, err});
            }
        }
    }
    if (!found_wrapper) {
        std.debug.warn("No C wrapper found (tried {s} and {s}). Continuing without C wrapper.\n", .{wrapper_candidates[0], wrapper_candidates[1]});
    }

    // Include Thorvg headers if the submodule was initialized and headers exist.
    const thorvg_include = "third_party/thorvg/include";
    const include_stat = cwd.stat(thorvg_include);
    if (include_stat) | _ | {
        exe.includeDirs += .{thorvg_include};
    } else |err| {
        if (err != fs.File.Error.FileNotFound) {
            std.debug.warn("warning: stat('{s}') returned error: {any}\n", .{thorvg_include, err});
        }
    }

    // Attempt to link with system library "thorvg"; if not present, the linker
    // step may fail later — that's expected until the library is available.
    exe.linkSystemLibrary("thorvg");

    exe.install();
}
