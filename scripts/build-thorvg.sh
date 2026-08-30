#!/usr/bin/env bash
set -euo pipefail

THORVG_DIR=third_party/thorvg
if [ ! -d "$THORVG_DIR" ]; then
  echo "Submódulo de Thorvg no encontrado en $THORVG_DIR. Ejecuta ./scripts/setup-submodules.sh"
  exit 1
fi

pushd "$THORVG_DIR"

# Dependencias del sistema (en CI ya deberían instalarse antes de invocar este script)
# Build con CMake + Ninja
if [ -f "CMakeLists.txt" ]; then
  mkdir -p build
  cd build
  cmake -G Ninja ..
  ninja
  echo "Thorvg build completo"
else
  echo "No se encontró CMakeLists.txt en el submódulo Thorvg. Ajustá este script según el layout del submódulo."
fi

popd
