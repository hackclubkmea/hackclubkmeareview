# Global Variables
MAX_CHANGE_LENGTH=10
CHANGABLE_FILE="./review.json"

# Getting changed file
FILE="$(git diff --name-only HEAD~1)"

if [ "$FILE" != "$CHANGABLE_FILE" ]; then
	echo "Changed files that were not ment to be changed"
	echo "${FILE}"
	exit 1
fi

CHANGED_LINES=$(git show HEAD~1:$CHANGABLE_FILE | diff -y --suppress-common-lines $CHANGABLE_FILE - | wc -l)

if [ "$CHANGED_LINES" -ne 1 ]; then
	echo "Should add excatly one line"
	echo "Trying to add ${CHANGED_LINES} lines"
	exit 1
fi

LAST_LENGTH=$(git show HEAD~1:./blackboard/addName.txt | wc -m)
NEW_LENGHT=$(git show HEAD~0:./blackboard/addName.txt | wc -m)

CHANGE_LENGHT=$(expr $NEW_LENGHT - $LAST_LENGTH)

if [ "$MAX_CHANGE_LENGTH" -lt "$CHANGE_LENGHT" ]; then
	echo "Should only add $MAX_CHANGE_LENGTH characters"
	echo "Trying to add $CHANGE_LENGHT characters"
	exit 1
fi  		

if [ "$CHANGE_LENGHT" -lt 1 ]; then
	echo "Should only add characters"
	echo "Trying to remove $CHANGE_LENGHT characters"
	exit 1
fi	 		

echo "All tests passed!"
exit 0
