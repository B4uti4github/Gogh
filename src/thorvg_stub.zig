// thorvg_stub.zig

// Este archivo contiene stubs/definiciones para la integración con Thorvg.
// En producción deberás reemplazar estos stubs por bindings reales a la librería C/C++

pub const ThorvgHandle = opaque {};

extern fn thorvg_init() c_int;
extern fn thorvg_finish();

// Ejemplo de wrapper mínimo
pub fn initThorvg() c_int {
    return thorvg_init();
}
