## Copy original drivers as driver1_orig.java and driver2_orig.java to software folder
## Going in to the zip folders and adding files.

parentDir="${PWD}"
resultFile="$parentDir/Lab2_output.txt"

#echo "Copying Original Drivers to software packages" >> $resultFile
#echo "" >> $resultFile
copyCmd="cp -rf /Users/manojgopale/Manoj/ECE373/Fall_2018/Lab2_grading/MyLibraryTest_grade.java src/org/library/system/."
eval "$copyCmd"

## Compiling all the drivers
#echo "Compiling all the classes" >> $resultFile
#echo "" >> $resultFile
javac -d bin -cp . src/org/library/*/*.java

## Running test driver
#echo "##############################" >> $resultFile
#echo "MyLibraryTest_grade output" >> $resultFile
#echo "" >> $resultFile
java -cp bin org.library.system.MyLibraryTest_grade >> $resultFile
#echo "" >> $resultFile
#echo "##############################" >> $resultFile
#echo "" >> $resultFile
