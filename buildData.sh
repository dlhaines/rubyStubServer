#!/usr/bin/env bash
# assemble a long list of json elements from these
# files.
### TTD:
# - read in the list of files.
# - change check for file_num to be size of the array of files.

### Add the appropriate list of files.
declare -a FILES=(
    'introInclassWeek2Communication.json'
    'introPreworkWeek2GoneWrong.json'
    'practiceAssignmentUpload.json'
    'introPreworkWeek2Communicate.json'
    'makeUpAssignment.json'
)

# count for number of elements to add
cnt=1
# array subscript
file_num=0
# elements in file
stop=31
# print appropriate separator even for last element.
SEPERATOR=""
echo "["
while [ $cnt -le $stop ]
do
    echo $SEPERATOR
    cat ${FILES[$file_num]}
    SEPERATOR=","
    cnt=$(( $cnt + 1 ))
    file_num=$(( $file_num + 1 ))
    if [ $file_num -ge 5 ]; then
        file_num=0
    fi
done
echo "]"
#end
