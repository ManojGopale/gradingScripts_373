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

##M## Copy original drivers as Driver1_orig.java, Driver2_orig.java and Driver3.java to software folder
##MparentDir="/Users/ual-laptop/Downloads/Assignment3_download/uniqueSubmission"
##M
##M## removing the diff file for next run
##MdiffFile="$parentDir/Assignment3_diff.txt"
##Mif [ -e "$diffFile" ]; then
##M	\rm -rf $diffFile
##M	touch $diffFile
##Melse 
##M	touch $diffFile
##Mfi
##M
##M## type d is to only find directories
##M#subFile=`find $parentDir/testScript/. -depth 1 -type d` 
##MsubFile=`find $parentDir/submission_unzipped/. -depth 1 -type d` 
##M
##Mfor studentFolder in $subFile;
##Mdo
##M  ## resultFile is storing the output from the Drivers
##M  ## We will be comparing it with the Original Driver from our runs and storing
##M  ## the diff results in diffFile
##M
##M  resultFile="$studentFolder/outputDrivers.txt"
##M  ## Removing resultFile if already present
##M  if [ -e "$resultFile" ]; then
##M  	\rm -rf $resultFile
##M  	touch $resultFile
##M  else 
##M  	touch $resultFile
##M  fi
##M
##M  cdCmd="cd $studentFolder"
##M  eval "$cdCmd"
##M
##M  echo "#############################"
##M  echo "$studentFolder"
##M  echo "#############################"
##M  echo ""
##M
##M  echo "Copying Original Drivers to software packages" >> $resultFile
##M  echo "" >> $resultFile
##M  copyCmd="cp -rf ~/Manoj/ECE373/Assignment3_drivers/Driver[1-3]*.java ./src/org/university/software/."
##M  eval "$copyCmd"
##M  
##M  ## Compiling all the drivers
##M  echo "Compiling all the classes" >> $resultFile
##M  echo "" >> $resultFile
##M  javac -d bin -cp . src/org/university/*/*.java
##M  
##M  ## Running all the drivers
##M  echo "##############################" >> $resultFile
##M  echo "Driver1 output" >> $resultFile
##M  echo "" >> $resultFile
##M  java -cp bin org.university.software.Driver1_orig >> $resultFile
##M  echo "" >> $resultFile
##M  echo "##############################" >> $resultFile
##M  echo "" >> $resultFile
##M  
##M  echo "Driver2 output" >> $resultFile
##M  echo "" >> $resultFile
##M  java -cp bin org.university.software.Driver2_orig >> $resultFile
##M  echo "" >> $resultFile
##M  echo "##############################" >> $resultFile
##M  echo "" >> $resultFile
##M  
##M  echo "Driver3 output" >> $resultFile
##M  echo "" >> $resultFile
##M  java -cp bin org.university.software.Driver3_orig >> $resultFile
##M
##M  ## Writing diff of original output and submission driver output in diffFile
##M  echo "#############################" >> $diffFile
##M  echo "$studentFolder" >> $diffFile
##M  echo "#############################" >> $diffFile
##M  echo "" >> $diffFile
##M
##M  diffCmd="diff -ws $parentDir/outputDrivers_original.txt $studentFolder/outputDrivers.txt"
##M  eval "$diffCmd" >> $diffFile
##M  echo "" >> $diffFile
##M
##M  cdParent="cd $parentDir/submission_unzipped"
##M  eval "$cdParent"
##Mdone

## Extra credit
## Remove Driver1-3.java from the folders.
## Whoever compiles will pass without errors, easy to grade
## Only copy Driver_extra.java and compile

parentDir="/Users/ual-laptop/Downloads/Assignment3_download/uniqueSubmission"

subFile=`find $parentDir/submission_unzipped/. -depth 1 -type d` 

## removing the diff file for next run
diffFileExtra="$parentDir/Assignment3_diffExtra.txt"
if [ -e "$diffFileExtra" ]; then
	\rm -rf $diffFileExtra
	touch $diffFileExtra
else 
	touch $diffFileExtra
fi


for studentFolder in $subFile;
do
  ## resultFile is storing the output from the Drivers
  ## We will be comparing it with the Original Driver from our runs and storing
  ## the diff results in diffFile

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

  #echo "Copying Original Drivers to software packages" >> $resultFile
  #echo "" >> $resultFile
  copyCmd="cp -rf ~/Manoj/ECE373/Assignment3_drivers/Driver_extra.java ./src/org/university/software/."
  eval "$copyCmd"
  
  ## Compiling all the drivers
  #echo "Compiling all the classes" >> $resultFile
  #echo "" >> $resultFile
  javac -d bin -cp . src/org/university/*/*.java
  
  ## Running extra credit driver
	echo "Driver_extra credit output" >> $resultFileExtra
	echo "" >> $resultFileExtra
	java -cp bin org.university.software.Driver_extra >> $resultFileExtra

  ## Writing diff of extra credit original output and submission driver output in diffFile
  echo "#############################" >> $diffFileExtra
  echo "$studentFolder" >> $diffFileExtra
  echo "#############################" >> $diffFileExtra
  echo "" >> $diffFileExtra

  diffCmd="diff -ws $parentDir/outputDrivers_extraCredit_original.txt $studentFolder/outputDrivers_extraCredit.txt"
  eval "$diffCmd" >> $diffFileExtra
  echo "" >> $diffFileExtra

  cdParent="cd $parentDir/submission_unzipped"
  eval "$cdParent"
done
