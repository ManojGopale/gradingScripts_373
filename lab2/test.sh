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
##MparentDir="/Users/manojgopale/Manoj/ECE373/Fall_2018/Lab2_grading/"
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

##### Lab2 ########

## Copy original drivers as Driver1_orig.java, Driver2_orig.java and Driver3.java to software folder
parentDir="/Users/manojgopale/Manoj/ECE373/Fall_2018/Lab2_grading/"

## removing the diff file for next run
diffFile="$parentDir/Lab2_diff.txt"
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

  resultFile="$studentFolder/Lab2_student_output.txt"
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

  ## Writing diff of original output and submission driver output in diffFile
  echo "#############################" >> $diffFile
  echo "$studentFolder" >> $diffFile
  echo "#############################" >> $diffFile
  echo "" >> $diffFile

  diffCmd="diff -ws $parentDir/Lab2_output_orig.txt $studentFolder/Lab2_student_output.txt"
  eval "$diffCmd" >> $diffFile
  echo "" >> $diffFile

  cdParent="cd $parentDir/submission_unzipped"
  eval "$cdParent"
done
