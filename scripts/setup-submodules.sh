#!/usr/bin/env bash
set -euo pipefail

echo "Inicializando submódulos..."
git submodule update --init --recursive

# Opcional: cambiar a una rama/etiqueta concreta del submódulo
# pushd third_party/thorvg
# git fetch --all --tags
# git checkout <tag-or-sha>
# popd

echo "Submódulos listos."
