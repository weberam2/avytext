#!/bin/bash

while [[ $# -gt 0 ]]; do
  opt="$1"
  shift;

  case "$opt" in
    "-a"|"--lat"      ) lat="$1"; shift;;
    "-o"|"--long"     ) long="$1"; shift;;
    *                   ) echo "ERROR: Invalid option: \""$opt"\"" >&2
                          exit 1;;
  esac
done

if [[ "$lat" == "" || "$long" == "" ]]; then
    echo "ERROR: Options -a and -o require arguments." 2>&1
    exit 1
fi

report=$(curl -s --location --request GET "api.avalanche.ca/forecasts/en/products/point?lat=${lat}&long=${long}" | jq -r '.report')
day1=$(echo $report | jq -r '.dangerRatings[0].date.display')
day1_alp=$(echo $report | jq -r '.dangerRatings[0].ratings.alp.rating.display')
day1_tln=$(echo $report | jq -r '.dangerRatings[0].ratings.tln.rating.display')
day1_btl=$(echo $report | jq -r '.dangerRatings[0].ratings.btl.rating.display')

day2=$(echo $report | jq -r '.dangerRatings[1].date.display')
day2_alp=$(echo $report | jq -r '.dangerRatings[1].ratings.alp.rating.display')
day2_tln=$(echo $report | jq -r '.dangerRatings[1].ratings.tln.rating.display')
day2_btl=$(echo $report | jq -r '.dangerRatings[1].ratings.btl.rating.display')

day3=$(echo $report | jq -r '.dangerRatings[2].date.display')
day3_alp=$(echo $report | jq -r '.dangerRatings[2].ratings.alp.rating.display')
day3_tln=$(echo $report | jq -r '.dangerRatings[2].ratings.tln.rating.display')
day3_btl=$(echo $report | jq -r '.dangerRatings[2].ratings.btl.rating.display')

echo ${day1:0:3}${day1_alp:0:3}${day1_tln:0:3}${day1_btl:0:3}${day2:0:3}${day2_alp:0:3}${day2_tln:0:3}${day2_btl:0:3}${day3:0:3}${day3_alp:0:3}${day3_tln:0:3}${day3_btl:0:3}

