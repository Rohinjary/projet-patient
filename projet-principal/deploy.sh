#!/bin/bash
set -e

JAVA17_HOME="/usr/lib/jvm/java-17-openjdk-amd64"

SRC_DIR="src/main/java"
RESOURCES_DIR="src/main/resources"
WEBAPP_DIR="src/main/webapp"
BUILD_DIR="build"
LIB_DIR="lib"

TOMCAT_HOME="/opt/apache-tomcat-10.1.28"
SERVLET_API_JAR="$TOMCAT_HOME/lib/servlet-api.jar"
DEPS_CP=$(echo $LIB_DIR/*.jar | tr ' ' ':')

APP_NAME="cabinet"
APP_DIR="$TOMCAT_HOME/webapps/$APP_NAME"

rm -rf $BUILD_DIR
mkdir -p $BUILD_DIR/classes

find $SRC_DIR -name "*.java" > sources.txt
"$JAVA17_HOME/bin/javac" -parameters -cp "$SERVLET_API_JAR:$DEPS_CP" -d $BUILD_DIR/classes @sources.txt
rm sources.txt

if [ -d "$RESOURCES_DIR" ]; then
cp -r $RESOURCES_DIR/* $BUILD_DIR/classes/
fi

rm -rf "$APP_DIR"
mkdir -p "$APP_DIR/WEB-INF/classes" "$APP_DIR/WEB-INF/lib"
cp -r $WEBAPP_DIR/* "$APP_DIR/"
cp -r $BUILD_DIR/classes/* "$APP_DIR/WEB-INF/classes/"

# tous les jars (framework.jar compris) vont dans WEB-INF/lib, sauf servlet-api (fourni par Tomcat)
for jar in $LIB_DIR/*.jar; do
if [ "$(basename $jar)" != "servlet-api.jar" ]; then
cp "$jar" "$APP_DIR/WEB-INF/lib/"
fi
done

rm -rf "$TOMCAT_HOME/work/Catalina/localhost/$APP_NAME"

echo "✅ Deploiement termine : $APP_DIR"
echo "➡  http://localhost:8080/$APP_NAME/login"