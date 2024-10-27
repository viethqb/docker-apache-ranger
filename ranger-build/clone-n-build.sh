#!/usr/bin/env bash

set -e

cd /build-src

if [ -d "ranger/.git" ]; then
  echo "Ranger exists, just checkout new revsion"
  cd ranger
  HEAD=$(git rev-parse --short HEAD)
  if [ "$HEAD" != "$REVISION" ]; then
    echo "Revision changed, updated new codes from upstream!"
    git reset --hard
    git checkout master
    git pull origin master
  fi
else
  git clone https://github.com/apache/ranger.git
fi

cd /build-src/ranger

echo "Working on revsion ${REVISION}"
git checkout ${REVISION}
mvn versions:set -DnewVersion=${VERSION}-${REVISION}

echo "[Rev ${REVISION}] Pull dependencies"
mvn dependency:resolve  -Daether.dependencyCollector.impl=bf -Dmaven.artifact.threads=8
echo "[Rev ${REVISION}] Compiled"
mvn package -DskipTests
