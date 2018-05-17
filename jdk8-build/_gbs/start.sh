#!/usr/bin/env bash

cd /src

FILENAME="$1"

while [[ "$FILENAME" != "/" && "$FILENAME" != "." ]]; do
    chown germanium:germanium $FILENAME
    FILENAME=$(dirname $FILENAME)
done # [[ "$FILENAME" != "/" ]]

if grep -q '[^[:space:]]' < "$1"; then
    chmod +x ./$1
    ./$1
else
    /$1
fi

