OIFS="$IFS"
IFS=$'\n'
zipFile=`find *.zip`

for subzipFile in $zipFile;
do
	echo "$subzipFile";
	cmd="unzip -d submission_unzipped \"$subzipFile\""
	echo "$cmd"
	eval $cmd;
done
IFS="$OIFS"

## Now go int he submission folder and copy run test
cd submission_unzipped

## removing the results file for next run
\rm -rf ~/Manoj/ECE373/Fall_2018/Assignment_1/testFolder/submission_unzipped/Assignment1_results.txt
touch ~/Manoj/ECE373/Fall_2018/Assignment_1/testFolder/submission_unzipped/Assignment1_results.txt

## type d is to only find directories
subFile=`find . -depth 1 -type d` 

for studentFolder in $subFile;
do
	echo "" >> /Users/manojgopale/Manoj/ECE373/Fall_2018/Assignment_1/testFolder/submission_unzipped/Assignment1_results.txt;
	echo "###############" >> /Users/manojgopale/Manoj/ECE373/Fall_2018/Assignment_1/testFolder/submission_unzipped/Assignment1_results.txt;
	echo "$studentFolder" >> /Users/manojgopale/Manoj/ECE373/Fall_2018/Assignment_1/testFolder/submission_unzipped/Assignment1_results.txt;
	copyCmd="cp -rf ~/Manoj/ECE373/Fall_2018/gradingScripts_373/newRun.sh $studentFolder";
	echo "$copyCmd";
	eval "$copyCmd";

	cd "$studentFolder";
	testCmd="source newRun.sh >> /Users/manojgopale/Manoj/ECE373/Fall_2018/Assignment_1/testFolder/submission_unzipped/Assignment1_results.txt";
	eval "$testCmd";
	echo "" >> /Users/manojgopale/Manoj/ECE373/Fall_2018/Assignment_1/testFolder/submission_unzipped/Assignment1_results.txt;
	echo "###############" >> /Users/manojgopale/Manoj/ECE373/Fall_2018/Assignment_1/testFolder/submission_unzipped/Assignment1_results.txt;
	cd ../
done
