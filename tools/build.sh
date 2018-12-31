#!/bin/bash

./bake.sh

DIST_DIR=../dist
if [ -d "$DIST_DIR" ]; then rm -Rf $DIST_DIR; fi
mkdir $DIST_DIR

cp -R ../media $DIST_DIR
cp ../index.html $DIST_DIR
cp ../game.min.js $DIST_DIR

sed -i -e 's~lib/game/main.js~game.min.js~g' $DIST_DIR/index.html
sed -i '/impact.js/d' $DIST_DIR/index.html

rm ../game.min.js