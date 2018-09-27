## Copy original drivers as driver1_orig.java and driver2_orig.java to software folder
## Going in to the zip folders and adding files.

## Compiling all the drivers
javac -d bin -cp . src/org/university/*/*.java

## Running all the drivers
java -cp bin org.university.software.Driver1
java -cp bin org.university.software.Driver2
