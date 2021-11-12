#!/usr/bin/env bash

find -mindepth 1 -maxdepth 1 -type d -exec sh -c "cd {}; pwd; go test --tags integration ./...; cd - > /dev/null" \;
