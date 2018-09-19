testFile=`find . | egrep Test | egrep -v bin |  sed "s/\.\///g"`
echo $testFile

## rev reverses the string and we use cut to get from 2nd delimiter and then again reverse it.
## This removes .java from the variable
testClass=`find . | egrep Test | egrep -v bin | sed "s/\.\///g" | sed "s/\//\./g" | rev | cut -d "." -f2-9 | rev | cut -d "." -f2-9`
echo $testClass
echo ""

## srcFile will have all the .java files, which can be compiled at once
srcFile=`find . | egrep src | egrep java | egrep -v Test | sed "s/\.\///g"`

## Checking for bin in the directory
## There should be space after '[' and before ']' in the if statement
if [ -d bin ]; then
  echo "Directory bin exists in ${PWD}"
  \rm -rf bin/*
else
  echo "Directory bin does not exist in ${PWD}"
  mkdir bin
fi

## Linking libraries rather than copying them
linkFiles=`ls -ld ~/Manoj/ECE373/Fall_2018/gradingScripts_373/newLib_Jupiter/* | awk '{print $9}'`
## You need to be in lib directory before you execute this loop
## Junit5 is superset of JUnit4 libraries. So no need to have separate loop for JUnit5
## Just link all the libraries
#for i in $linkFiles;
#do 
#	cmd="ln -s $i";
#	eval $cmd; 
#done


echo ""
if [ -e lib ]; then
  echo "Directory lib exists in ${PWD}"
	## If lib is present and any of the libraries are not linked then re-link everything
  if [ -e lib/junit-4.13-20180730.170926-150.jar -a -e lib/hamcrest-core-1.3.jar -a -e lib/apiguardian-1.0.0-20170908.181424-6.jar \
		-a -e lib/junit-jupiter-api-5.1.0-20180218.190948-382.jar -a -e lib/junit-jupiter-engine-5.1.0-20180218.190950-382.jar \
		-a -e lib/junit-jupiter-migrationsupport-5.1.0-20180218.190951-382.jar -a -e lib/junit-jupiter-params-5.1.0-20180218.190953-382.jar \
		-a -e lib/junit-platform-commons-1.1.0-20180218.190954-382.jar -a -e lib/junit-platform-engine-1.1.0-20180218.190958-381.jar \
		-a -e lib/junit-platform-launcher-1.1.0-20180218.191059-380.jar -a -e lib/junit-platform-runner-1.1.0-20180218.191100-380.jar \
		-a -e lib/junit-platform-suite-api-1.1.0-20180218.191102-380.jar -a -e lib/junit-vintage-engine-5.1.0-20180218.191104-236.jar \
		-a -e lib/opentest4j-1.0.0-20170730.202628-48.jar -a -e lib/apiguardian-api-1.0.0-20170909.133433-2.jar \
		-a -e lib/junit-platform-console-standalone-1.3.0-20180903.154750-256.jar ]; then
    echo "Junit is linked in lib directory"
  else
    cd lib
    echo "Linking junit in lib"
		## Links all the libraries in the newLib_Jupiter directory
		## Junit5 is superset of JUnit4 libraries. So no need to have separate loop for JUnit5
		## Just link all the libraries
		for i in $linkFiles;
		do 
			cmd="ln -s $i";
			eval $cmd; 
		done
    cd ../
  fi
else
  echo "Creating lib directory and linking junit and hamcrest"
  mkdir lib
  cd lib
  ## Create softlinks in the lib directory
	## Links all the libraries in the newLib_Jupiter directory
	## Junit5 is superset of JUnit4 libraries. So no need to have separate loop for JUnit5
	## Just link all the libraries
	for i in $linkFiles;
	do 
		cmd="ln -s $i";
		eval $cmd; 
	done
  cd ../
fi

## Create soft links in the lib directory

echo ""
## Compiling Person and PersonTest
echo "javac -d bin -cp src $srcFile"
javac -d bin -cp src $srcFile

echo ""
echo "javac -d bin -cp bin:lib/* $testFile"
javac -d bin -cp bin:lib/* $testFile

## Running the JUnit test
#echo "java -cp bin:lib/* org.junit.runner.JUnitCore $testClass"
## JUnit 4 test case run
#java -cp bin:lib/* org.junit.runner.JUnitCore $testClass

## JUnit 5 testcase run
## java -jar lib/junit-platform-console-standalone-1.3.0-20180903.154750-256.jar -cp bin:lib/* -c university.debug.CourseTest
#echo "java -jar lib/junit-platform-console-standalone-1.3.0-20180903.154750-256.jar -cp bin:lib/* -c $testClass"
#java -jar lib/junit-platform-console-standalone-1.3.0-20180903.154750-256.jar -cp bin:lib/* -c $testClass


## Testing for JUnit libraries, since testing commands are different for Junt5 and Junit4
j5=`less .classpath | egrep JUNIT | egrep 5`
j4=`less .classpath | egrep JUNIT | egrep 4`
j3=`less .classpath | egrep JUNIT | egrep 3`

## "" are required.
## https://stackoverflow.com/questions/3869072/test-for-non-zero-length-string-in-bash-n-var-or-var

#if [ -z "$j5" ]; then
#	echo "JUnit5 not present in file"
#else
#	echo "JUnit5 present"
#fi
#
#if [ -z "$j4" ]; then
#	echo "JUNIT4 not present"
#else 
#	echo "JUNit4 present"
#fi

echo ""
## -n tests if the variable is non zero in length
if [ -n "$j5" ]; then
	echo "JUnit5 present"
	echo "java -jar lib/junit-platform-console-standalone-1.3.0-20180903.154750-256.jar -cp bin:lib/* -c $testClass"
	j5Cmd="java -jar lib/junit-platform-console-standalone-1.3.0-20180903.154750-256.jar -cp bin:lib/* -c $testClass"
	echo "j5Cmd = $j5Cmd"
	eval "$j5Cmd"
elif [ -n "$j4" ]; then
	echo "JUnit4 present"
	echo "java -cp bin:lib/* org.junit.runner.JUnitCore $testClass"
	## JUnit 4 test case run
	j4Cmd="java -cp bin:lib/* org.junit.runner.JUnitCore $testClass"
	echo "J4 Cmd = $j4Cmd"
	eval "$j4Cmd"
elif [ -n "$j3" ]; then
	echo "JUnit3 present"
else 
	echo "JUnit5, Junit4 and Junit3 missing"
fi
