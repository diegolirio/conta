SNAPSHOT="SNAPSHOT"
NEW_VERSION=$(cat pom.xml | grep "^    <version>.*</version>$" | awk -F'[><]' '{print $3}')

case "$NEW_VERSION" in
    *$SNAPSHOT* ) echo "Version OK";;
    * ) echo "Error... version should to be $SNAPSHOT";;
esac

OLD_VERSION=$(cat pom.xml | grep "^    <version>.*</version>$" | awk -F'[><]' '{print $3}')
#MVN_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)
mvn release:update-versions          
NEW_VERSION=$(cat pom.xml | grep "^    <version>.*</version>$" | awk -F'[><]' '{print $3}')
sed -i "s/$OLD_VERSION/$NEW_VERSION/g" devops/develop/digio-kubernetes.yml 
