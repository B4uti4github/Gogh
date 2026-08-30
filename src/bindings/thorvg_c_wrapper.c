#include "src/bindings/thorvg_c_wrapper.h"

// Nota: depende de que el submódulo third_party/thorvg provea los headers
// y la API esperada. Ajustá las rutas/includes si el submódulo tiene diferente layout.

// Intentamos usar la API C de ThorVG (nombres comunes: tvg_init / tvg_finish)
// Si el submódulo no expone exactamente esos nombres, este wrapper sirve como punto
// de adaptación para compilar y mapear las funciones necesarias.

// Incluimos la cabecera principal (ruta relativa al submódulo)
#include "third_party/thorvg/include/tvg.h"

int thorvg_wrapper_init(void) {
    // tvg_init devuelve un valor de resultado, aquí retornamos 0 en caso de éxito
    auto res = tvg_init();
    return (res == TVG_RESULT_SUCCESS) ? 0 : -1;
}

void thorvg_wrapper_finish(void) {
    tvg_finish();
}
