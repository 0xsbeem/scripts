#!/bin/bash

# weather_array[0] = precipitation
# weather_array[1] = Temperature
# weather_array[2] = Humidity
# weather_array[3] = One character weather code
get_weather () {
	weather=$(curl -s wttr.in?format="%p~%t~%h~%x")
	IFS='~' read -r -a weather_array <<< "$weather"
	echo "Precip: ${weather_array[0]} "\
		"Temp: ${weather_array[1]} "\
		"Humidity: ${weather_array[2]} "\
		"Weather: ${weather_array[3]} "
}

let loop==0
weather_string=$(get_weather)
while true; do
	# Update weather every 5 minutes (300 seconds)
	if [[ $loop%300 -eq 0 ]]; then
		weather_string=$(get_weather)
		let loop=0
	fi
	xsetroot -name " $weather_string | $(date '+%b %d %a') | $(date '+%H:%M') "
	let loop=$loop+15 # Track number of seconds
	sleep 15
done
