testFile=`find . | egrep test | egrep java | sed "s/\.\///g"`
echo $testFile

## rev reverses the string and we use cut to get from 2nd delimiter and then again reverse it.
## This removes .java from the variable
testClass=`find . | egrep test | egrep java | sed "s/\.\///g" | sed "s/\//\./g" | rev | cut -d "." -f2-9 | rev | cut -d "." -f2-9`
echo $testClass

## srcFile will have all the .java files, which can be compiled at once
srcFile=`find . | egrep src | egrep java | sed "s/\.\///g"`

## Checking for bin in the directory
## There should be space after '[' and before ']' in the if statement
if [ -d bin ]; then
  echo "Directory bin exists in ${PWD}"
  \rm -rf bin/*
else
  echo "Directory bin does not exist in ${PWD}"
  mkdir bin
fi

if [ -e lib ]; then
  echo "Directory lib exists in ${PWD}"
  if [ -e lib/junit-4.10.jar ]; then
    echo "Junit is linked in lib directory"
  else
    cd lib
    echo "Linking junit in lib"
    ln -s ~/Downloads/junit-4.10.jar
    cd ../
  fi

  if [ -e lib/hamcrest-core-1.3.jar ]; then
    echo "Hamcrest is linked in lib directory"
  else
    cd lib
    echo "Linking hamcrest in lib"
    ln -s ~/Downloads/hamcrest-core-1.3.jar
    cd ../
  fi
else
  echo "Creating lib directory and linking junit and hamcrest"
  mkdir lib
  cd lib
  ## Create softlinks in the lib directory
  ln -s ~/Downloads/junit-4.10.jar
  ln -s ~/Downloads/hamcrest-core-1.3.jar
  cd ../
fi

## Create soft links in the lib directory

## Compiling Person and PersonTest
javac -d bin -cp src $srcFile
echo "javac -d bin -cp src $srcFile"

javac -d bin -cp bin:lib/junit-4.10.jar:lib/hamcrest-core-1.3.jar $testFile

## Running the JUnit test
java -cp bin:lib/junit-4.10.jar:lib/hamcrest-core-1.3.jar org.junit.runner.JUnitCore $testClass
