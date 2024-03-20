#!/bin/bash

WORKING_DIR="$PWD"

if [ -z "$1" ]; then
  echo "Необходимо указать версию Minecraft в формате X.Y.Z (например, 1.12.2 или 1.20.1)!"
  exit 1
fi
MC_VERSION=$1
MC_SHORT_VERSION=$(echo "$MC_VERSION" | cut -d"." -f1,2)
MC_MINOR_VERSION=$(echo "$MC_VERSION" | cut -d"." -f2)

if [ -z "$2" ]; then
  echo "Необходимо порядковый номер сборки!"
  exit 1
fi
BUILD_NUMBER=$2

if [ "$MC_MINOR_VERSION" -gt "17" ]; then
    if [ -z "$3" ]; then
      echo "Необходимо указать директорию проекта TFC!"
      exit 1
    fi
    TFC_DIR=$3
fi

BUILD_DIR="${WORKING_DIR}/build"
RAW_DIR=${BUILD_DIR}/raw
MC_LANG_SOURCE_FILE="${TFC_DIR}/src/main/resources/assets/minecraft/lang/ru_ru.json"
MC_LANG_TARGET_DIR="${RAW_DIR}/assets/minecraft/lang"
TFC_LANG_SOURCE_FILE="${TFC_DIR}/src/main/resources/assets/tfc/lang/ru_ru.json"
TFC_LANG_TARGET_DIR="${RAW_DIR}/assets/tfc/lang"
PATCHOULI_SOURCE_DIR="${TFC_DIR}/resources"
PATCHOULI_BUILD_DIR="${TFC_DIR}/src/main/resources/assets/tfc/patchouli_books/field_guide/ru_ru"
PATCHOULI_TARGET_DIR=${RAW_DIR}/assets/tfc/patchouli_books/field_guide/ru_ru

PROJECT_NAME=$(basename -s .git `git config --get remote.origin.url`)
ARTIFACT_NAME="${PROJECT_NAME}-${MC_VERSION}-${BUILD_NUMBER}.zip"

echo "Сборка: ${ARTIFACT_NAME}"

echo "Очистка директории ${BUILD_DIR}"
rm -rf $BUILD_DIR
mkdir -p $RAW_DIR

if [ "$MC_MINOR_VERSION" -gt "17" ]; then
    echo "Очистка директории ${PATCHOULI_BUILD_DIR}"
    rm -rf $PATCHOULI_BUILD_DIR

    echo "Сборка актуальной локализации"
    cd $PATCHOULI_SOURCE_DIR
    pip3.10 install -r requirements.txt
    cd ..
    python3.10 ./resources/__main__.py --translate ru_ru book
    cd $WORKING_DIR

    echo "Копирование файлов перевода"
    mkdir -p $PATCHOULI_TARGET_DIR
    cp -rp ${PATCHOULI_BUILD_DIR}/* $PATCHOULI_TARGET_DIR

    echo "Копирование Minecraft lang файлов"
    mkdir -p $MC_LANG_TARGET_DIR
    cp -rp $MC_LANG_SOURCE_FILE ${MC_LANG_TARGET_DIR}/ru_ru.json

    echo "Копирование TFC lang файлов"
    mkdir -p $TFC_LANG_TARGET_DIR
    cp -rp $TFC_LANG_SOURCE_FILE ${TFC_LANG_TARGET_DIR}/ru_ru.json
fi

echo "Копирование метаданных ресурспака"
cp -rp ./src/${MC_SHORT_VERSION}/* $RAW_DIR

echo "Сборка zip архива"
cd $RAW_DIR
zip -q -0 -r "${BUILD_DIR}/${ARTIFACT_NAME}" * >/dev/null 2>&1
cd $WORKING_DIR

echo "Сборка выполнена успешно!"
exit 0
