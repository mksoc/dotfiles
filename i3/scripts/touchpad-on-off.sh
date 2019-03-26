#!/bin/bash

# Get device ID
id=$(xinput list | grep Touchpad | cut -f 2 | cut -d = -f 2)

# Get touchpad status
status=$(xinput list-props $id | grep "Device Enabled"| awk '{print $4}')

# Set the correct value
if [ $status -ne 0 ]
then
    xinput --disable $id 
    notify-send -u low -i input-touchpad "Touchpad disabled"
else
    xinput --enable $id
    notify-send -u low -i input-touchpad "Touchpad enabled"
fi
