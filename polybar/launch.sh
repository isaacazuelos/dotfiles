#!/usr/bin/env bash

pkill polybar; 

while pgrep -x polybar >/dev/null; do 
	sleep 1; 
done; 

exec polybar bar1 -r
