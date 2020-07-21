#!/usr/bin/env bash

if [[ "$(docker images -q trailofbits/polytracker 2> /dev/null)" == "" ]]; then
    docker build -t trailofbits/polytracker .
fi
if [[ "$(docker images -q trailofbits/polytracker-demo-mupdf 2> /dev/null)" == "" ]]; then
    docker build -t trailofbits/polytracker-demo-mupdf -f examples/Dockerfile-mupdf.demo .
fi

docker run --read-only -ti --rm -e POLYTRACE="1" -e POLYPATH="$1" --mount type=bind,source="$(pwd)",target=/workdir trailofbits/polytracker-demo-mupdf:latest /polytracker/the_klondike/mupdf/build/debug/mutool_track draw "$1"
