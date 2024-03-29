#!/bin/sh
set -ex

# Get version
dart --version

# Get dependencies
pub install

# Run the tests
pub global activate coverage
OBSERVATORY_PORT=8000
COVERAGE_OUTPUT=coverage.json

dart --checked --observe=${OBSERVATORY_PORT} test/all.dart & \
pub global run coverage:collect_coverage \
    --port=${OBSERVATORY_PORT} \
    --out ${COVERAGE_OUTPUT} \
    --wait-paused \
    --resume-isolates & \
wait

pub global run coverage:format_coverage \
    --packages=.packages \
    --report-on lib \
    --in ${COVERAGE_OUTPUT} \
    --out lcov.info \
    --lcov
