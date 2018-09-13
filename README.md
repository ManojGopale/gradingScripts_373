# gradingScripts_373
Use newRun.sh in the root directory (parallel to src and test] in the assignments.
It will create bin and lib (link's junitXX.jar and hancrestXX.jar).

Creates the command to run all the classes in src folder.
Creates the command to run the TestClass in test folder.

Executes the TestClass and prints the results.
Print the last 2 lines to the result.txt or result.csv outside the assignment folder. This gives summary of execution.


## TO DO
create the command to link for junit4 and junit5 depending on the .classpath file.

create a script to go through all the assignemnts and printing the result in the results file. Kind of like a csv
source runNew.sh > results.csv or results.txt
