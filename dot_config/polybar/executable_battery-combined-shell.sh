#!/bin/sh

PATH_AC="/sys/class/power_supply/AC"
PATH_BATTERY_0="/sys/class/power_supply/BAT0"
PATH_BATTERY_1="/sys/class/power_supply/BAT1"

ac=0
battery_level_0=0
battery_level_1=0
battery_max_0=0
battery_max_1=0

if [ -f "$PATH_AC/online" ]; then
    ac=$(cat "$PATH_AC/online")
fi

if [ -f "$PATH_BATTERY_0/capacity" ]; then
    battery_level=$(cat "$PATH_BATTERY_0/capacity")
fi

battery_max=100 #$(("$battery_max_0 + $battery_max_1"))

battery_percent=$(($battery_level * 100))
battery_percent=$(($battery_percent / $battery_max))

if [ "$ac" -eq 1 ]; then
    icon=""

    if [ "$battery_percent" -gt 97 ]; then
        echo "$icon"
    else
        echo "$icon $battery_percent%"
    fi
else
    if [ "$battery_percent" -gt 85 ]; then
        icon=""
    elif [ "$battery_percent" -gt 60 ]; then
        icon=""
    elif [ "$battery_percent" -gt 35 ]; then
        icon=""
    elif [ "$battery_percent" -gt 10 ]; then
        icon=""
    else
        icon="#25"
    fi

    echo "$icon $battery_percent%"
fi

