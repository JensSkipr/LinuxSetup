#!/usr/bin/env bash

# Tests are in the same folder as code
# execute `go_cover`
#
# Tests are in a subfolder, e.g. "tests"
# execute `go_cover tests`

# Settings
CP=$(mktemp /tmp/coverage.XXXXX)

# Run tests and store cover profile
go test -coverprofile=${CP} -coverpkg . ./${1}

# Open page in your browser with the covered code
go tool cover -html=${CP}

# Cleanup coverage profile
rm ${CP}
