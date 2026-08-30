# Build Thorvg in CI

Este script es invocado por la CI y por desarrolladores que quieran compilar Thorvg localmente.

Requisitos de sistema (Ubuntu/Debian):
- cmake
- ninja-build
- build-essential
- libpng-dev
- libjpeg-dev
- libwebp-dev
- pkg-config

En CI el workflow instala estas dependencias antes de invocar este script.
