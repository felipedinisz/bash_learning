#!/bin/bash

myvar=1

while [[ $myvar -le 10 ]]; do
	echo $myvar 
	(( myvar += 1 ))
	sleep 0.5
done
