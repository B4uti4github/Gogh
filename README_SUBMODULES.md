Actualización: uso de submódulos

Se añadió un submódulo para Thorvg en third_party/thorvg.

Para inicializar los submódulos localmente:

1. Clonar el repo:
   git clone https://github.com/B4uti4github/Gogh.git
   cd Gogh
2. Inicializar submódulos:
   git submodule update --init --recursive
   # o usar el script
   ./scripts/setup-submodules.sh

3. Compilar (nota: Thorvg puede necesitar build con cmake y dependencias del sistema)
   zig build

Notas:
- Recomiendo fijar el submódulo a una etiqueta/commit estable para CI reproducible.
- Si Thorvg requiere pasos adicionales (cmake, ninja), el proceso está documentado en platform/esp32/README.md y en .github/workflows/ci.yml.
