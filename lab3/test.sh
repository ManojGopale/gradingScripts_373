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
##MparentDir="/Users/ual-laptop/Downloads/Lab3_Download/uniqueSubmissions/"
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

##### Lab3 ########

## Copy original drivers as Driver1_orig.java, Driver2_orig.java and Driver3.java to software folder
parentDir="/Users/ual-laptop/Downloads/Lab3_Download/uniqueSubmissions/submission_unzipped/submission_M2T"

## removing the diff file for next run
diffFile="$parentDir/Lab3_diff.txt"
if [ -e "$diffFile" ]; then
	\rm -rf $diffFile
	touch $diffFile
else 
	touch $diffFile
fi

classDiffFile="$parentDir/Lab3_classDiff.txt"
if [ -e "$classDiffFile" ]; then
	\rm -rf $classDiffFile
	touch $classDiffFile
else 
	touch $classDiffFile
fi

## type d is to only find directories
#subFile=`find $parentDir/testScript/. -depth 1 -type d` 
subFile=`find $parentDir/. -depth 1 -type d` 

for studentFolder in $subFile;
do
  ## resultFile is storing the output from the Drivers
  ## We will be comparing it with the Original Driver from our runs and storing
  ## the diff results in diffFile

  resultFile="$studentFolder/Lab3_student_output.txt"
	onlyClassFile="$studentFolder/Lab3_student_onlyClass.txt"

  ## Removing resultFile if already present
  if [ -e "$resultFile" ]; then
  	\rm -rf $resultFile
  	touch $resultFile
  else 
  	touch $resultFile
  fi

  echo "#############################"
  echo "$studentFolder"
  echo "#############################"
  echo ""

	codeDir=`find "$studentFolder"/. -type d -depth 1 | egrep -i "generate"`
	
	egrep "public|\private|\protected|\class" "$codeDir"/Book.java > "$resultFile"
	egrep "public|\private|\protected|\class" "$codeDir"/Employee.java >> "$resultFile"
	egrep "public|\private|\protected|\class" "$codeDir"/Library.java >> "$resultFile"
	egrep "public|\private|\protected|\class" "$codeDir"/Person.java >> "$resultFile"
	egrep "public|\private|\protected|\class" "$codeDir"/Professor.java >> "$resultFile"
	egrep "public|\private|\protected|\class" "$codeDir"/Student.java >> "$resultFile"
	egrep "public|\private|\protected|\class" "$codeDir"/University.java >> "$resultFile"

	egrep "class" "$codeDir"/Book.java > "$onlyClassFile"
	egrep "class" "$codeDir"/Employee.java >> "$onlyClassFile"
	egrep "class" "$codeDir"/Library.java >> "$onlyClassFile"
	egrep "class" "$codeDir"/Person.java >> "$onlyClassFile"
	egrep "class" "$codeDir"/Professor.java >> "$onlyClassFile"
	egrep "class" "$codeDir"/Student.java >> "$onlyClassFile"
	egrep "class" "$codeDir"/University.java >> "$onlyClassFile"

	#echo "Copying Original Drivers to software packages" >> $resultFile
	#echo "" >> $resultFile

  ## Writing diff of original output and submission driver output in diffFile
  echo "#############################" >> $diffFile
  echo "$studentFolder" >> $diffFile
  echo "#############################" >> $diffFile
  echo "" >> $diffFile

  diffCmd="diff -ws $parentDir/Lab3_output_orig.txt $studentFolder/Lab3_student_output.txt"
  eval "$diffCmd" >> $diffFile
  echo "" >> $diffFile

  ## Writing diff of only classes from the submission
  echo "#############################" >> $classDiffFile
  echo "$studentFolder" >> $classDiffFile
  echo "#############################" >> $classDiffFile
  echo "" >> $classDiffFile

  classDiffCmd="diff -ws $parentDir/Lab3_output_onlyClass.txt $studentFolder/Lab3_student_onlyClass.txt"
  eval "$classDiffCmd" >> $classDiffFile
  echo "" >> $classDiffFile

  cdParent="cd $parentDir/"
  eval "$cdParent"
done
