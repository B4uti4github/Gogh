const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "gogh",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });

    // Requerido si interactúas con C / ThorVG
    exe.linkLibC();

    // Comprobar y añadir el C wrapper
    const wrapper_candidates = [_][]const u8{
        "src/bindings/thorvg_c_wrapper.c",
        "src/wrapper.c",
    };

    var found_wrapper = false;
    for (wrapper_candidates) |p| {
        if (std.fs.cwd().access(p, .{})) |_| {
            exe.addCSourceFile(.{
                .file = .{ .path = p },
                .flags = &.{},
            });
            found_wrapper = true;
            break;
        } else |_| {} // Sintaxis correcta en lugar de 'catch'
    }

    if (!found_wrapper) {
        std.debug.print("Warning: No C wrapper found; continuing without it.\n", .{});
    }

    // Incluir cabeceras de ThorVG si el directorio existe
    const thorvg_include = "third_party/thorvg/include";
    if (std.fs.cwd().access(thorvg_include, .{})) |_| {
        exe.addIncludePath(.{ .path = thorvg_include });
    } else |_| {} // Sintaxis correcta en lugar de 'catch'

    // Enlazar librería del sistema
    exe.linkSystemLibrary("thorvg");

    // Instalar ejecutable en zig-out/bin
    b.installArtifact(exe);

    // Permitir ejecutar con 'zig build run'
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Ejecutar la aplicación");
    run_step.dependOn(&run_cmd.step);
}
