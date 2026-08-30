# Gogh

Gogh es un visor de juegos tscn/Godot optimizado, escrito en Zig, que utiliza Thorvg (una librería de render vectorial usada por Godot) para ofrecer un runtime ligero. El objetivo es permitir ejecutar juegos simples incluso en dispositivos con recursos limitados (por ejemplo ESP32) cuando sea posible, gracias a un pipeline de render y bindings optimizados.

Author: B4uti4Dev

Estado: Esqueleto del proyecto creado. Ver ROADMAP.md para el progreso (30% inicial).

Stack principal
- Zig (lenguaje principal)
- Thorvg (render vectorial) — bindings/FFI con C
- Toolchains opcionales: esp-idf / PlatformIO para plataforma ESP32

Quickstart (desarrollo local)
1. Instalar Zig (https://ziglang.org/download/).
2. Clonar el repositorio y entrar al directorio:
   git clone https://github.com/B4uti4github/Gogh.git
   cd Gogh
3. Compilar (desarrollo):
   zig build
4. Ejecutar el binario creado (si aplica):
   ./zig-out/bin/gogh

Notas sobre ESP32 y despliegue en hardware:
Ver platform/esp32/README.md para opciones, limitaciones y guía de cross-compile. Integrar Thorvg en ESP32 probablemente requerirá compilar partes en C y adaptar el pipeline al hardware disponible.

Licencia: ISC
