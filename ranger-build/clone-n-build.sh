#!/usr/bin/env bash

cd /build-src
git clone https://github.com/apache/ranger.git
cd ranger
git checkout ${REVISION}
mvn versions:set -DnewVersion=${VERSION}-${REVISION}
mvn package -DskipTests -Daether.dependencyCollector.impl=bf -Dmaven.artifact.threads=8
