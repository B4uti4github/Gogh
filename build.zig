const std = @import("std");

pub fn build(b: *std.Build) void {
    // 1. Obtener target y nivel de optimización desde la línea de comandos
    // (Ej: -Dtarget=x86_64-linux -Doptimize=ReleaseFast)
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // 2. Definir el ejecutable
    // Nota: En Zig 0.11 se usa b.path("...") para resolver rutas relativas
    const exe = b.addExecutable(.{
        .name = "gogh",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    // -------------------------------------------------------------
    // Integración de C / C Wrapper
    // -------------------------------------------------------------
    // Enlazar la biblioteca estándar de C (si tu wrapper usa stdlib.h, printf, etc.)
    exe.linkLibC();

    // Añadir el archivo fuente en C
    exe.addCSourceFile(.{
        .file = b.path("src/wrapper.c"),
        .flags = &.{"-std=c99"}, // Opcional: flags del compilador C
    });

    // Añadir directorio de cabeceras (.h) si las necesitas desde Zig o C
    exe.addIncludePath(b.path("src/include"));
    // -------------------------------------------------------------

    // 3. Registrar la instalación en el directorio final (zig-out/bin)
    b.installArtifact(exe);

    // 4. Paso opcional para ejecutar la app con `zig build run`
    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Ejecutar la aplicación");
    run_step.dependOn(&run_cmd.step);
}
