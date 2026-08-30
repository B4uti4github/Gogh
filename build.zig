const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("gogh", "src/main.zig");
    exe.setBuildMode(mode);

    // Añadir el wrapper C para enlazar con Thorvg (si el submódulo está inicializado)
    // Ajustá la ruta si tu layout de submódulo difiere.
    exe.addCSourceFile("src/bindings/thorvg_c_wrapper.c", &.{});

    // Incluir headers del submódulo (si existen)
    // exe.includeDirs += .{"third_party/thorvg/include"};

    // Si Thorvg requiere link a librerías del sistema, añadirlas aquí.
    // exe.linkSystemLibrary("pthread");

    exe.install();
}
