## Copy original drivers as driver1_orig.java and driver2_orig.java to software folder
## Going in to the zip folders and adding files.

parentDir="${PWD}"
resultFile="$parentDir/outputDrivers.txt"

echo "Copying Original Drivers to software packages" >> $resultFile
echo "" >> $resultFile
copyCmd="cp -rf ~/Manoj/ECE373_Drivers_assignment2/* ./src/org/university/software/."
eval "$copyCmd"

## Compiling all the drivers
echo "Compiling all the classes" >> $resultFile
echo "" >> $resultFile
javac -d bin -cp . src/org/university/*/*.java

## Running all the drivers
echo "##############################" >> $resultFile
echo "Driver1 output" >> $resultFile
echo "" >> $resultFile
java -cp bin org.university.software.Driver1_orig >> $resultFile
echo "" >> $resultFile
echo "##############################" >> $resultFile
echo "" >> $resultFile

echo "Driver2 output" >> $resultFile
echo "" >> $resultFile
java -cp bin org.university.software.Driver2_orig >> $resultFile
echo "" >> $resultFile
echo "##############################" >> $resultFile
echo "" >> $resultFile

echo "Driver3 output" >> $resultFile
echo "" >> $resultFile
java -cp bin org.university.software.Driver3_orig >> $resultFile

