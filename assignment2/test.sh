## This should be run in the folder which has unique latest submission from the students. This is done manually.
## Create a script to move or copy the submissions to the parentDir. 
## Run this script from here

## This has to be run in the directory where zip files are present
## IFS is the delimiter for bash shell
## We need to set it to neew line, so as to not have folders with spaces in there names split
OIFS="$IFS"
IFS=$'\n'
zipFile=`find *.zip`

## parentDir should be the folder with zip files
##unique_latest_Submission => directory containing unique latest submissions in zip format
parentDir="/Users/ual-laptop/Downloads/Assignment2/unique_latest_submissions/"

## Creating submission_zipped is not present
if [ -d $parentDir/submission_unzipped ]; then
  echo "submission_unzipped present in the folder $parentDir"
else            
  echo "submission_unzippped is not present in the folder $parentDir."
  echo "Creating submission_unzipped directory"
  mkCmd="mkdir $parentDir/submission_unzipped";
	echo "$mkCmd";
	eval "$mkCmd";
fi

for subzipFile in $zipFile;
do
	echo "$subzipFile";
	## We need the zipFile in "" so that they can account for spaces in the 
	## file name
	cmd="unzip -d $parentDir/submission_unzipped \"$subzipFile\""
	echo "$cmd"
	eval $cmd;
done
IFS="$OIFS"

## Comment till this point.
## Go throught the submission_unzipped to find any duplicates or folders with spaces in the name or anything out of ordinary.
## Most pf the times, it is not zipped in the folder, so will have to remove those submissions before running the unzip.
## Reyes will have a duplicate. Keep one submission.
## After sanity check, run this script from the parentDir. 

##### Asignment 2 ########

## Copy original drivers as Driver1_orig.java, Driver2_orig.java and Driver3.java to software folder
parentDir="/Users/ual-laptop/Downloads/Assignment2/unique_latest_submissions/"

## removing the diff file for next run
diffFile="$parentDir/Assignment2_diff.txt"
if [ -e "$diffFile" ]; then
	\rm -rf $diffFile
	touch $diffFile
else 
	touch $diffFile
fi

## type d is to only find directories
#subFile=`find $parentDir/testScript/. -depth 1 -type d` 
subFile=`find $parentDir/submission_unzipped/. -depth 1 -type d` 

for studentFolder in $subFile;
do
  ## resultFile is storing the output from the Drivers
  ## We will be comparing it with the Original Driver from our runs and storing
  ## the diff results in diffFile

  resultFile="$studentFolder/outputDrivers.txt"
  ## Removing resultFile if already present
  if [ -e "$resultFile" ]; then
  	\rm -rf $resultFile
  	touch $resultFile
  else 
  	touch $resultFile
  fi

  cdCmd="cd $studentFolder"
  eval "$cdCmd"

  echo "#############################"
  echo "$studentFolder"
  echo "#############################"
  echo ""

  echo "Copying Original Drivers to software packages" >> $resultFile
  echo "" >> $resultFile
  copyCmd="cp -rf ~/Manoj/ECE373_Drivers_assignment2/Driver* ./src/org/university/software/."
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

  ## Writing diff of original output and submission driver output in diffFile
  echo "#############################" >> $diffFile
  echo "$studentFolder" >> $diffFile
  echo "#############################" >> $diffFile
  echo "" >> $diffFile

  diffCmd="diff -ws $parentDir/output.txt $studentFolder/outputDrivers.txt"
  eval "$diffCmd" >> $diffFile
  echo "" >> $diffFile

  cdParent="cd $parentDir/submission_unzipped"
  eval "$cdParent"
done
