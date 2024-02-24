#!/usr/bin/env.sh bash
export RESOURCE_PACK_NAME=TFC-Patchouli-RUS
if [ -z "$RESOURCE_PACK_VERSION" ]; then
    export RESOURCE_PACK_VERSION=DEV
fi
export ARTEFACT_NAME=$RESOURCE_PACK_NAME-$RESOURCE_PACK_VERSION.zip

export WORKING_DIR="$PWD"
export SOURCE_BOOK_DIR=$WORKING_DIR/src/main
export SOURCE_PACK_METADATA_DIR=$WORKING_DIR/src/resources
export BUILD_DIR=$WORKING_DIR/build
export TARGET_BOOK_DIR=$BUILD_DIR/raw/assets/tfc/patchouli_books/book/ru_ru
export TARGET_PACK_METADATA_DIR=$BUILD_DIR/raw

echo "Remove build directory"
rm -rf $BUILD_DIR

echo "Create build dir"
mkdir -p $BUILD_DIR

echo "Copy sources"

echo TARGET_BOOK_DIR=$TARGET_BOOK_DIR
mkdir -p $TARGET_BOOK_DIR
cp -rp $SOURCE_BOOK_DIR/* $TARGET_BOOK_DIR/

echo TARGET_PACK_METADATA_DIR=$TARGET_PACK_METADATA_DIR
mkdir -p $TARGET_PACK_METADATA_DIR
cp -rp $SOURCE_PACK_METADATA_DIR/* $TARGET_PACK_METADATA_DIR/

echo "Build"
cd $BUILD_DIR/raw
echo ARTEFACT_NAME=$ARTEFACT_NAME
zip -q -0 -r $BUILD_DIR/$ARTEFACT_NAME * >/dev/null 2>&1
cd $WORKING_DIR
