#!/usr/bin/env python3

import subprocess
import time

cmd = 'cat /sys/class/thermal/thermal_zone0/temp'

while True:
    temp_str = '' 
    with open('/sys/class/thermal/thermal_zone0/temp', 'r') as f:
        temp_str = f.read()
    temp = float(temp_str) / 1000

    print("CPU Temp: {:.1f}°C".format(temp), end='\r')
    time.sleep(.1)
