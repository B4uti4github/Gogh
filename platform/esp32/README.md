Platform notes para ESP32

Objetivo: explicar limitaciones y opciones para compilar/ejecutar partes de Gogh en ESP32.

Puntos clave:
- Thorvg es una librería de render vectorial que normalmente se compila en C/C++ y usa malloc, floats y APIs gráficas que pueden no estar disponibles en un ESP32 sin adaptación.
- Zig puede interoperar con C, por lo que la estrategia recomendada es mantener la lógica en Zig y compilar/usar la parte de render (Thorvg) como una librería C estática ligada al firmware.
- El toolchain Xtensa (ESP32) no es soportado oficialmente por Zig en todas sus versiones; es probable que necesites usar esp-idf y bindings C para la parte nativa.

Sugerencias prácticas:
1. Implementar bindings C para Thorvg y exponer únicamente las funciones necesarias (inicializar, dibujar primitivas, rasterizar a framebuffer).
2. Usar esp-idf para la parte de firmware; crear un componente que integre la librería C creada.
3. Para desarrollo, preparar un contenedor Docker con esp-idf y toolchain para CI.

CI y pruebas en hardware:
- Debido a las variaciones de toolchain, el workflow de CI para builds ESP32 está incluido como plantilla u opcional. Probar en hardware real es recomendado.

Limitaciones:
- Memoria y rendimiento: muchos juegos Godot usan features (scripting, físicas, recursos) que superan la capacidad de un ESP32. Enfocar en juegos muy simples con assets vectoriales ligeros.
