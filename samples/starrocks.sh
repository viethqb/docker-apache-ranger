#!/usr/bin/env bash
curl -fsSL https://raw.githubusercontent.com/StarRocks/ranger/master/agents-common/src/main/resources/service-defs/ranger-servicedef-starrocks.json\
  | curl -u admin:rangerR0cks! -X POST -H "Accept: application/json" -H "Content-Type: application/json" 'http://localhost:6080/service/plugins/definitions' -d@-
