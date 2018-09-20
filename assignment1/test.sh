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
parentDir="/Users/manojgopale/Manoj/ECE373/Fall_2018/Assignment_1/Assignment_1_submission/submission_wo_duplicates/"

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

## Now go in the submission folder and copy run test
cd1Cmd="cd $parentDir/submission_unzipped"
echo ""
echo "Going into $parentDir/submission_unzipped folder"
eval "$cd1Cmd"

## removing the results file for next run
resultFile="$parentDir/submission_unzipped/Assignment1_results.txt"
if [ -e "$resultFile" ]; then
	\rm -rf $resultFile
	touch $resultFile
else 
	touch $resultFile
fi

## type d is to only find directories
subFile=`find $parentDir/submission_unzipped/. -depth 1 -type d` 

for studentFolder in $subFile;
do
	echo "" >> $resultFile;
	echo "###############" >> $resultFile;
	echo "$studentFolder" >> $resultFile;
	copyCmd="cp -rf ~/Manoj/ECE373/Fall_2018/gradingScripts_373/newRun.sh $studentFolder";
	echo "$copyCmd";
	eval "$copyCmd";

	cdCmd="cd $studentFolder";
	eval "$cdCmd";
	testCmd="source newRun.sh >> $resultFile";
	eval "$testCmd";
	echo "" >> $resultFile;
	echo "###############" >> $resultFile;
	cdParent="cd $parentDir/submission_unzipped";
	touchCmd="touch tmp.txt";
	eval "$touchCmd";
	eval "$cdParent"
done
