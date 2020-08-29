0#!/bin/bash
read -p 'What format do you want to use? Select png, jpg, pnm, ppm, tiff ' format
read -p 'What do you want the filename prefix to be? ' prefix
read -p 'Pick a dpi/ppi resolution ' resolution
#command
#scanimage --format=pnm --mode=color --progress --resolution=600 > set2-tsep19470412-XXXX.ppm
scanimage --format=$format --mode=color --progress --resolution=$resolution > $prefix-$resolutiondpi-$(date +%s).$format
echo "Do you want to scan another page?"
#bash is drawing all over itself so lets see if 'wait' will stop that
wait 3
while true;
do
#do I put a "for loop" here if I want to increment the output name?
    read -r -p "Yes or no? " response   
    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
       #scanimage --format=$format --mode=color --progress --resolution=$resolution > $prefix-$(date +%s).$format
	scanimage --format=$format --mode=color --progress --resolution=$resolution > $prefix-$resolutiondpi-$(date +%s).$format
       #bash draws on itself when the 'true' statement loops, see if 'wait' will fix 
        wait 3
    else
        exit 0
    fi
done
