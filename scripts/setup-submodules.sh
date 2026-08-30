#!/usr/bin/env bash
set -euo pipefail

echo "Inicializando submódulos..."

git submodule update --init --recursive

# Intentar fijar el submódulo third_party/thorvg a la última release (etiqueta)
if [ -d "third_party/thorvg" ]; then
  pushd third_party/thorvg >/dev/null
  echo "Obteniendo tags del submódulo..."
  git fetch --tags --force
  LATEST_TAG=$(git describe --tags "$(git rev-list --tags --max-count=1)" 2>/dev/null || true)
  if [ -n "$LATEST_TAG" ]; then
    echo "Encontrada última etiqueta: $LATEST_TAG — haciendo checkout"
    git checkout "$LATEST_TAG" || echo "No se pudo hacer checkout de $LATEST_TAG"
  else
    echo "No se encontró etiqueta — dejando la rama por defecto del submódulo"
  fi
  popd >/dev/null
fi

echo "Submódulos listos."
