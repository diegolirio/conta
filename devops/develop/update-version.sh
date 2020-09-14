SNAPSHOT="SNAPSHOT"
#OLD_VERSION=$(cat pom.xml | grep "^    <version>.*</version>$" | awk -F'[><]' '{print $3}')
OLD_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
NEW_VERSION=$OLD_VERSION

case "$OLD_VERSION" in
    *$SNAPSHOT* ) echo "Version OK";;
    * ) echo "Error... version should to be $SNAPSHOT"; exit 1;
esac

MVN_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
mvn release:update-versions          
NEW_VERSION=$(cat pom.xml | grep "^    <version>.*</version>$" | awk -F'[><]' '{print $3}')
#sed -i "s/$OLD_VERSION/$NEW_VERSION/g" devops/develop/digio-kubernetes.yml
