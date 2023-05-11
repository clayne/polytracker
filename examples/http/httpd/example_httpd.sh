#!/usr/bin/env bash

if [[ "$(docker images -q trailofbits/polytracker 2>/dev/null)" == "" ]]; then
	docker build -t trailofbits/polytracker -f ../../Dockerfile ../../
fi
if [[ "$(docker images -q trailofbits/polytracker-demo-http-httpd 2>/dev/null)" == "" ]]; then
	docker build -t trailofbits/polytracker-demo-http-httpd .
fi

# NOTE: cannot pass --read-only because httpd needs to be able to write to /usr/local/apache2/logs/error_log
docker run -ti --rm -e POLYPATH="$1" --mount type=bind,source="$(pwd)",target=/workdir trailofbits/polytracker-demo-http-httpd:latest /polytracker/examples/http/httpd/harness_httpd.sh "$1"
