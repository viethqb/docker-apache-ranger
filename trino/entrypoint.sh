#!/usr/bin/env bash

set -ex

/opt/ranger/enable-trino-plugin.sh
/usr/lib/trino/bin/run-trino
