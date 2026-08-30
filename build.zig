const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Use the standard release options helper from std.build (Zig 0.11+)
    const mode = std.build.standardReleaseOptions(b);

    const exe = b.addExecutable("gogh", "src/main.zig");
    exe.setBuildMode(mode);

    // Add the C wrapper (assumes the file exists in the repo)
    exe.addCSourceFile("src/bindings/thorvg_c_wrapper.c", &.{});

    // Include headers from the Thorvg submodule
    exe.includeDirs += .{"third_party/thorvg/include"};

    // Link with thorvg (adjust name/path if the library builds to a different name)
    exe.linkSystemLibrary("thorvg");

    exe.install();
}
