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

# making sure the input indeed has exactly 5 alphabetical characters and consists of (syg) case sensitivities
if [[ "${#char_colors}" -ne 5 ]] || [[ ! "$char_colors" =~ ^[sygSYG]{5}$ ]]; then
echo "didn't follow instructions..."
read -p "Press enter to quit the game"
exit 1
fi

# Extracting all the 5 alphabetic characters word from the the words file
words_pool=$(curl -s https://raw.githubusercontent.com/dwyl/english-words/master/words.txt | grep -xE '[[:alpha:]]{5}')

# Looping as number of times as the length of the input string -5
temporary_pool="$words_pool"
for i in $(seq 0 4); do
  # If s (silver), then present the words that do not consist at all (in any position) of the char attributed to s
  if [[ "${char_colors:i:1}" == [Ss] ]]; then
  suitable_words=$(echo "$temporary_pool" | grep -i -E -v "${user_word:${i}:1}")

  # If y (yellow), then present the words that do consist of this character (attributed to color yellow) but in a different position
  elif [[ "${char_colors:i:1}" == [Yy] ]]; then
  suitable_words=$(echo "$temporary_pool" | grep -i -E "${user_word:${i}:1}" | grep -i -E -v "^.{${i}}${user_word:${i}:1}.*$")

  # If g (green), then present the words that do consist of this character (attributed to color green) at the same position as user_word
  elif [[ "${char_colors:i:1}" == [Gg] ]]; then
  suitable_words=$(echo "$temporary_pool" | grep -i -E "^.{${i}}${user_word:${i}:1}.*$")
  fi
if [[ -n "$suitable_words" ]]; then
temporary_pool="$suitable_words"
fi
done
