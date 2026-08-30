He actualizado la documentación para incluir el uso de submódulos y cómo inicializarlos.

- Añadí .gitmodules apuntando a https://github.com/thorvg/thorvg
- Añadí scripts/setup-submodules.sh
- Añadí un wrapper C mínimo en src/bindings/ y su header
- Añadí bindings Zig en src/thorvg_bindings.zig
- Actualicé build.zig para compilar el wrapper C (ajustá includeDirs si es necesario)
- Actualicé CI para hacer checkout con submodules y un paso opcional de build de Thorvg

Revisá la rama feature/thorvg-submodule-and-bindings y si querés que fije el submódulo a una etiqueta/commit concreto decímelo y lo seteo.
