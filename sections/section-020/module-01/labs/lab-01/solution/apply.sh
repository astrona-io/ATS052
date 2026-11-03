#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl -n starfleet label pod shuttle role=client --overwrite
sleep 5
