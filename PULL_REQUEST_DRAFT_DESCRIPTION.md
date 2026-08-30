# PR draft template: Add Thorvg submodule, C wrapper, Zig bindings and CI integration

Este PR prepara la integración inicial de Thorvg como submódulo y añade un wrapper C y bindings Zig
para permitir compilar y enlazar Thorvg en el proyecto.

Cambios incluidos:
- Añadido submódulo third_party/thorvg apuntando al repositorio upstream.
- scripts/setup-submodules.sh: inicializa submódulos y fixa el submódulo a la última release disponible.
- scripts/build-thorvg.sh: script para compilar Thorvg usando CMake/Ninja (si el submódulo lo soporta).
- src/bindings/thorvg_c_wrapper.c/h: wrapper C mínimo que adapta la API de Thorvg.
- src/thorvg_bindings.zig: FFI Zig hacia el wrapper.
- build.zig: configuración para compilar el wrapper y linkear con la librería Thorvg.
- CI: workflow actualizado para inicializar submódulos, instalar dependencias (cmake, ninja, libpng, libjpeg, libwebp)
  y compilar Thorvg cuando sea posible.
- script de pin al último tag encontrado en el submódulo para reproducibilidad por defecto.

Checklist
- [ ] Verificar que el layout de headers de Thorvg coincida con third_party/thorvg/include/tvg.h
- [ ] Si no, ajustar includes en src/bindings/thorvg_c_wrapper.c y build.zig
- [ ] Probar CI y corregir pasos si la compilación de Thorvg falla en el submódulo

Nota: este PR es un draft. Pushea cambios o comentarios y luego abrí el PR final hacia main.
