#!/bin/bash

SNAPSHOT="SNAPSHOT"
OLD_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
NEW_VERSION=$OLD_VERSION

case "$OLD_VERSION" in
    *$SNAPSHOT* ) echo "Version OK";;
    * ) echo "Error... version should to be $SNAPSHOT"; exit 1;
esac

mvn release:update-versions          
NEW_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
sed -i "s/$OLD_VERSION/$NEW_VERSION/g" devops/develop/conta-kubernetes.yml