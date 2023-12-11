
# colors
bgc="#000"
fgc="#FFF"

s=$"[    ] $volume"
m=$"[|   ] $volume"
l=$"[||  ] $volume"
xl=$"[||| ] $volume"
xxl=$"[||||] $volume"
xxxl=$"[||||] !!! $volume"

# Function to get the current desktop number
get_current_desktop() {
  bspc wm -g | awk '/^.*:.*:.*:/{print $2}'
}

# Function to update the Lemonbar
update_lemonbar() {
  desktop=$(get_current_desktop)
  echo -e "%{l}$desktop"
}

# Define the clock
Clock() {
  DATETIME=$(date "+%a %b %d, %T")
  echo "%{F$fgc}%{B$bgc}$DATETIME%{F-}%{B-}"
}

CPU() {
	usage=$(awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "%"; }' <(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat))
	usage_int=$(printf "%.0f" "$usage")

if [ $usage_int -lt 1 ]; then
		echo "C $s"
	elif [ $usage_int -lt 26 ]; then
		echo "C $m"
	elif [ $usage_int -lt 51 ]; then
		echo "C $l"
	elif [ $usage_int -lt 76 ]; then
		echo "C $xl"
	elif [ $usage_int -lt 101 ]; then
		echo "C $xxl"
	else
		echo "C %{F#FF0000}%{B$bgc} $xxxl %{F-}%{B-}"
	fi

}

Mem() {
	used=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
	used_int=$(printf "%.0f" "$used")


	if [ $used_int -lt 1 ]; then
		echo "M $s"
	elif [ $used_int -lt 26 ]; then
		echo "M $m"
	elif [ $used_int -lt 51 ]; then
		echo "M $l"
	elif [ $used_int -lt 76 ]; then
		echo "M $xl"
	elif [ $used_int -lt 101 ]; then
		echo "M $xxl"
	else
		# echo "$xxxl"
		echo "M %{F#FF0000}%{B$bgc} $xxxl %{F-}%{B-}"
	fi


}

Vol() {
	volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '\d+(?=%)' | head -n 1)

	if [ $volume -lt 1 ]; then
		echo "V $s"
	elif [ $volume -lt 26 ]; then
		echo "V $m"
	elif [ $volume -lt 51 ]; then
		echo "V $l"
	elif [ $volume -lt 76 ]; then
		echo "V $xl"
	elif [ $volume -lt 101 ]; then
		echo "V $xxl"
	else
		# echo "$xxxl"
		echo "V %{F#FF0000}%{B$bgc} $xxxl %{F-}%{B-}"
	fi

}

# Define the battery status
Battery() {
  BATTERY_INFO=$(acpi)
  STATUS=$(echo "$BATTERY_INFO" | awk '{print $3}')
  PERCENTAGE=$(echo "$BATTERY_INFO" | awk -F, '{print $2}' | tr -d ' %')

  if [ "$STATUS" = "Charging," ]; then
    # Battery is charging (Green)
    echo "%{F#87ff66}%{B$bgc} Battery: $PERCENTAGE% %{F-}%{B-}"
  elif [ "$PERCENTAGE" -lt 10 ]; then
    # Battery is below 10% (Red)
    echo "%{F#FF0000}%{B$bgc} !!! Battery: $PERCENTAGE% %{F-}%{B-}"
  else
    # Battery is not charging and above 10% (White)
    echo "%{F$fgc}%{B$bgc} Battery: $PERCENTAGE% %{F-}%{B-}"
  fi
}

# Launch lemonbar
while true; do
	echo "%{l}%{F$fgc}%{B$bgc} $(Vol)   $(CPU)   $(Mem) %{c}%{F$fgc}%{B$bgc} $(update_lemonbar) %{c}%{F$fgc}%{B$bgc} $(Clock) %{F$fgc}%{B$bgc} %{r}$(Battery)"
  sleep 0.5
done

