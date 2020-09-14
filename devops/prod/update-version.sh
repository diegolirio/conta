SNAPSHOT="SNAPSHOT"
NEW_VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec)

case "$NEW_VERSION" in
    *$SNAPSHOT* ) echo "Version OK";;
    * ) echo "Error... version should to be $SNAPSHOT ====> $NEW_VERSION"; exit 1;
esac

NEW_VERSION_RELEASE=$(echo $NEW_VERSION | sed -e "s/$SNAPSHOT/RELEASE/g")

mvn versions:set -DnewVersion=$NEW_VERSION_RELEASE
sed -i "s/REPLACE_VERSION/$NEW_VERSION_RELEASE/g" devops/prod/conta-kubernetes-deployment-v2.yml
