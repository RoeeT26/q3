#!/bin/bash
#Q3

read -p "please write a word with 5 alphabetically characters: " user_word

# making sure the input word indeed has 5 alphabetical characters
if [[ "${#user_word}" -ne 5 ]] || [[ ! "$user_word" =~ ^[a-zA-Z]{5}$ ]]; then
echo "didn't follow instructions..."
read -p "Press enter to quit the game"
exit 1
fi

read -p "choose s for silver, y for yellow, g for green: " char_colors
