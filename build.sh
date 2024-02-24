#!/usr/bin/env.sh bash

# Проверка на наличие аргумента (тега)
if [ -z "$1" ]; then
  echo "Тег не указан!"
  exit 1
fi
TAG=$1
REPO_NAME=$(basename -s .git `git config --get remote.origin.url`)

WORKING_DIR="$PWD"
BUILD_DIR="${WORKING_DIR}/build"
ARTIFACT_NAME="${REPO_NAME}-${TAG}.zip"

# Определение папки исходников на основе тега
if [[ $TAG == 1.*.* ]]; then
  cd "${WORKING_DIR}/src/tfc"
elif [[ $TAG == 2.*.* ]]; then
  cd "${WORKING_DIR}/src/tfc2"
elif [[ $TAG == 3.*.* ]]; then
  cd "${WORKING_DIR}/src/tfc3"
else
  echo "Неверный формат тега! Должен быть 1.x.x, 2.x.x или 3.x.x"
  exit 1
fi

# Создание директории для сборки, если она не существует
mkdir -p ${BUILD_DIR}

# Сборка артефакта
zip -q -0 -r "${BUILD_DIR}/${ARTIFACT_NAME}" * >/dev/null 2>&1

echo "Артефакт собран: ${BUILD_DIR}/${ARTIFACT_NAME}"

cd ${WORKING_DIR}
