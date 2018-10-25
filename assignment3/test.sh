##M## This should be run in the folder which has unique latest submission from the students. This is done manually.
##M## Create a script to move or copy the submissions to the parentDir. 
##M## Run this script from here
##M
##M## This has to be run in the directory where zip files are present
##M## IFS is the delimiter for bash shell
##M## We need to set it to neew line, so as to not have folders with spaces in there names split
##MOIFS="$IFS"
##MIFS=$'\n'
##MzipFile=`find *.zip`
##M
##M## parentDir should be the folder with zip files
##M##unique_latest_Submission => directory containing unique latest submissions in zip format
##MparentDir="/Users/ual-laptop/Downloads/Assignment3_download/uniqueSubmission"
##M
##M## Creating submission_zipped is not present
##Mif [ -d $parentDir/submission_unzipped ]; then
##M  echo "submission_unzipped present in the folder $parentDir"
##Melse            
##M  echo "submission_unzippped is not present in the folder $parentDir."
##M  echo "Creating submission_unzipped directory"
##M  mkCmd="mkdir $parentDir/submission_unzipped";
##M	echo "$mkCmd";
##M	eval "$mkCmd";
##Mfi
##M
##Mfor subzipFile in $zipFile;
##Mdo
##M	echo "$subzipFile";
##M	## We need the zipFile in "" so that they can account for spaces in the 
##M	## file name
##M	cmd="unzip -d $parentDir/submission_unzipped \"$subzipFile\""
##M	echo "$cmd"
##M	eval $cmd;
##Mdone
##MIFS="$OIFS"

## Comment till this point.
## Go throught the submission_unzipped to find any duplicates or folders with spaces in the name or anything out of ordinary.
## Most pf the times, it is not zipped in the folder, so will have to remove those submissions before running the unzip.
## Reyes will have a duplicate. Keep one submission.
## After sanity check, run this script from the parentDir. 

##### Asignment 3 ########

## Copy original drivers as Driver1_orig.java, Driver2_orig.java and Driver3.java to software folder
parentDir="/Users/ual-laptop/Downloads/Assignment3_download/uniqueSubmission"

## removing the diff file for next run
diffFile="$parentDir/Assignment3_diff.txt"
if [ -e "$diffFile" ]; then
	\rm -rf $diffFile
	touch $diffFile
else 
	touch $diffFile
fi

## removing the diff file for next run
diffFileExtra="$parentDir/Assignment3_diffExtra.txt"
if [ -e "$diffFileExtra" ]; then
	\rm -rf $diffFileExtra
	touch $diffFileExtra
else 
	touch $diffFileExtra
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

	resultFileExtra="$studentFolder/outputDrivers_extraCredit.txt"
  ## Removing resultFileExtra if already present
  if [ -e "$resultFileExtra" ]; then
  	\rm -rf $resultFileExtra
  	touch $resultFileExtra
  else 
  	touch $resultFileExtra
  fi

  cdCmd="cd $studentFolder"
  eval "$cdCmd"

  echo "#############################"
  echo "$studentFolder"
  echo "#############################"
  echo ""

  echo "Copying Original Drivers to software packages" >> $resultFile
  echo "" >> $resultFile
  copyCmd="cp -rf ~/Manoj/ECE373/Assignment3_drivers/Driver* ./src/org/university/software/."
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

	##Mecho "Driver_extra credit output" >> $resultFileExtra
	##Mecho "" >> $resultFileExtra
	##Mjava -cp bin org.university.software.Driver_extra >> $resultFileExtra

  ## Writing diff of original output and submission driver output in diffFile
  echo "#############################" >> $diffFile
  echo "$studentFolder" >> $diffFile
  echo "#############################" >> $diffFile
  echo "" >> $diffFile

  diffCmd="diff -ws $parentDir/outputDrivers_original.txt $studentFolder/outputDrivers.txt"
  eval "$diffCmd" >> $diffFile
  echo "" >> $diffFile

  ##M## Writing diff of extra credit original output and submission driver output in diffFile
  ##Mecho "#############################" >> $diffFileExtra
  ##Mecho "$studentFolder" >> $diffFileExtra
  ##Mecho "#############################" >> $diffFileExtra
  ##Mecho "" >> $diffFileExtra

  ##MdiffCmd="diff -ws $parentDir/outputDrivers_extraCredit_original.txt $studentFolder/outputDrivers_extraCredit.txt"
  ##Meval "$diffCmd" >> $diffFileExtra
  ##Mecho "" >> $diffFileExtra

  cdParent="cd $parentDir/submission_unzipped"
  eval "$cdParent"
done
