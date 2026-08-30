const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "gogh",
        // En Zig 0.11.0 se usa .{ .path = "..." } en lugar de b.path(...)
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    // -------------------------------------------------------------
    // C Wrapper (Zig 0.11.0)
    // -------------------------------------------------------------
    exe.linkLibC();

    exe.addCSourceFile(.{
        .file = .{ .path = "src/wrapper.c" },
        .flags = &.{"-std=c99"},
    });

    exe.addIncludePath(.{ .path = "src/include" });
    // -------------------------------------------------------------

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Ejecutar la aplicación");
    run_step.dependOn(&run_cmd.step);
}
