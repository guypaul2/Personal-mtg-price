#!/bin/bash
printf "" > OUT.txt
filename='IN.txt'
n=1
cr=$'\r'
while read line; do
line="${line%$cr}"
json_val=$(curl "https://api.scryfall.com/cards/named?fuzzy=${line}")
nameEng=$(jq -r '.name' <<< "$json_val")
eur=$(jq -r '.prices.eur' <<< "$json_val")
eurFoil=$(jq -r '.prices.eur_foil' <<< "$json_val")
printf "$line\t$nameEng\t${eur/./,}\t${eurFoil/./,}\n" >> OUT.txt
n=$((n+1))
echo $n
done < $filename
