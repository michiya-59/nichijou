#!/bin/bash
set -e

rm -f /nichijou/tmp/pids/server.pid

exec "$@"

