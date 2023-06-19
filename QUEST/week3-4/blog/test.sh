#!/bin/zsh

# grep -E "りんご|みかん" test.txt
FRUIT="りんご"
fruit_data=$(grep -E "$FRUIT" test.txt)
echo $fruit_data
echo "$fruit_data" | sed -E 's/(.+):.+:.+/\1/'
echo "$fruit_data" | sed -E 's/.+:(.+):.+/\1/'
echo "$fruit_data" | sed -E 's/.+:.+:(.+)/\1/'
