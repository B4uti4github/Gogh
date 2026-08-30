const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("gogh", "src/main.zig");
    exe.setBuildMode(mode);

    // Añadir el wrapper C para enlazar con Thorvg (si el submódulo está inicializado)
    exe.addCSourceFile("src/bindings/thorvg_c_wrapper.c", &.{});

    // Incluir headers del submódulo (si existen)
    exe.includeDirs += .{"third_party/thorvg/include"};

    // Intentar linkear con la librería thorvg (suponiendo libthorvg.a / libthorvg.so disponible
    // en ruta de link o en third_party/thorvg/build). Ajustar según el nombre final de la librería.
    exe.linkSystemLibrary("thorvg");

    exe.install();
}
