#!/bin/bash

# Get device ID
id=$(xinput list | grep Touchpad | cut -f 2 | cut -d = -f 2)

# Get Accel Speed prop ID
prop=$(xinput list-props $id | grep -m 1 'Accel Speed' | cut -d '(' -f 2 | cut -d ')' -f 1)

# Set the correct value
xinput set-prop $id $prop 0.5