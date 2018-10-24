genDir="${PWD}"
resultFile="$genDir/Lab3_student_output.txt"
onlyClassFile="$genDir/Lab3_student_onlyClass.txt"

codeDir=`find "$genDir"/. -type d -depth 1 | egrep -i "generate"`

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

