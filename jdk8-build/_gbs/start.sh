#!/usr/bin/env bash

cd /src

FILENAME="$1"

while [[ "$FILENAME" != "/" && "$FILENAME" != "." ]]; do
    chown germanium:germanium $FILENAME
    FILENAME=$(dirname $FILENAME)
done # [[ "$FILENAME" != "/" ]]

test -x $1 || chmod +x .$1

$1

