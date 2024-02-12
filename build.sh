#!/bin/sh

echo "Cleaning existing classes..."
find . -name \*.class -exec rm {} \;

echo "Creating build directory..."
mkdir -p src/build

echo "Compiling source code and unit tests..."
javac -classpath .:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar ./src/main/java/*.java ./src/test/java/*.java -d src/build
if [ $? -ne 0 ] ; then echo BUILD FAILED!; exit 1; fi

echo "Running unit tests..."
java -cp .:lib/junit-4.12.jar:lib/hamcrest-core-1.3.jar:src/build org.junit.runner.JUnitCore EdgeConnectorTest
if [ $? -ne 0 ] ; then echo TESTS FAILED!; exit 1; fi

echo "Running application..."
java -classpath .:src/build RunEdgeConvert
