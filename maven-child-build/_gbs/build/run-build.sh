#!/usr/bin/env bash

env

echo mvn "${MAVEN_EXTRA_PARAMETERS}" --settings /m2/settings.xml clean install
if [[ "$MAVEN_EXTRA_PARAMETERS" != "" ]]; then
    mvn "${MAVEN_EXTRA_PARAMETERS}" --settings /m2/settings.xml clean install
else
    mvn --settings /m2/settings.xml clean install
fi # [[ "$MAVEN_EXTRA_PARAMETERS" != "" ]]
