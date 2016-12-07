# Node CI

This docker image sets up yarn, some browsers and Xvft needed to run
some tests in a CI environment.

Your Dockerfile can be:

    FROM jcmuller/node_ci

    ADD entrypoint.sh /usr/local/bin
    CMD entrypoint.sh

Run it with entrypoint.sh could look like:

    #!/bin/bash

    Xvfb -ac -screen scrn 1280x2000x24 :9.0 &
    export DISPLAY=:9.0

    xvfb-run --server-args="-screen 0 1280x2000x24" \
      DO_SOMETHING
