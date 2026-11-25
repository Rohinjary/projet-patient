#!/bin/bash
set -e

JAVA17_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

(cd ../framework && ./deploy.sh)
cp ../framework/framework.jar lib/framework.jar

APP_NAME="framework"
SRC_DIR="src/main/java"
RESOURCES_DIR="src/main/resources"
WEBAPP_DIR="src/main/webapp"
BUILD_DIR="build"
LIB_DIR="lib"

TOMCAT_HOME="/opt/apache-tomcat-10.1.28"
SERVLET_API_JAR="$TOMCAT_HOME/lib/servlet-api.jar"
DEPS_CP=$(echo $LIB_DIR/*.jar | tr ' ' ':')

APP_DIR="$TOMCAT_HOME/webapps/patient"
JAR_NAME="framework.jar"

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/classes $BUILD_DIR/jar

find $SRC_DIR -name "*.java" > sources.txt
"$JAVA17_HOME/bin/javac" -parameters -cp "$SERVLET_API_JAR:$DEPS_CP" -d $BUILD_DIR/classes @sources.txt

if [ $? -ne 0 ]; then
echo "❌ ERREUR COMPILATION"
exit 1
fi
rm sources.txt

if [ -d "$RESOURCES_DIR" ]; then
cp -r $RESOURCES_DIR/* $BUILD_DIR/classes/
fi

"$JAVA17_HOME/bin/jar" cf $BUILD_DIR/jar/$JAR_NAME -C $BUILD_DIR/classes .

rm -rf "$APP_DIR"
mkdir -p "$APP_DIR/WEB-INF/classes"
cp -r $WEBAPP_DIR/* "$APP_DIR/"
cp -r $BUILD_DIR/classes/* "$APP_DIR/WEB-INF/classes/"

mkdir -p "$APP_DIR/WEB-INF/lib"
cp $BUILD_DIR/jar/$JAR_NAME "$APP_DIR/WEB-INF/lib/"

for jar in $LIB_DIR/*.jar; do
if [ "$(basename $jar)" != "servlet-api.jar" ]; then
cp "$jar" "$APP_DIR/WEB-INF/lib/"
fi
done

rm -rf "$TOMCAT_HOME/work/Catalina/localhost/patient"

echo "✅ Deploiement termine : $APP_DIR"