#script to scan images
#set variables
#$DPI=
#$FOURDIGITOUTNUMBER
#$OUTPUTNAME
#add "read" command to set image prefix and suffix
#add "read" command to set dpi
#add "wait" or "sleep" command before setting a key press that will go ahead with next scan
#this command works as expected
#scanimage --format=pnm --mode=color --progress --resolution=100 > set1-tsep19470412-test.ppm
#is command I would likely use
#scanimage --format=pnm --mode=color --progress --resolution=600 > set2-tsep19470412-XXXX.ppm


#!/bin/bash
####################################################\
##                                                ###
##  scanpix.sh                                    ###
##  v 1.1.1                                       ###
##  Photo scanning script                         ###
##                                                ###
##  Scans a photo, alerts the user when           ###
##  finished, and quits or scans another.         ###
##  Useful for bulk scanning photos while         ###
##  Doing other computer work.                    ###
##                                                ###
##  requires: SANE scanimage, zenity              ###
##  `sudo apt-get install scanimage zenity`       ###
##                                                ###
##  Keith Irwin 2016                              ###
##  (https://keithirwin.us/contact)               ###
##                                                ###
#####################################################
#####################################################

################# SET THESE VALUES ##################
## Find and parse scanner name
echo "Finding scanner... "
SCANIMAGE=$(scanimage -L)
SCANNER=$(echo ${SCANIMAGE:8} | grep -oP ".*(?=')")
echo "Set scanner to $SCANNER"
#####################################################

###################### RUNTIME ######################

# Ask user for a folder to scan into
FOLDER=$(zenity --entry \
      	--title="Scan location" \
	--text="Scan photos to (no trailing slash): " \
	--entry-text="$HOME/Desktop/scan")

# User didn't enter a folder
if [ ! -d "$FOLDER" ]; then

	# That's not a directory! 
	zenity --error \
		--title="Error: Scan location not found" \
		--text="Couldn't find $FOLDER.  Try again (no trailing slashes)"

	# Give up
	exit 1

# Try try again
fi

# Wait for first photo to be placed
zenity --question \
	--title="Prepare scan" \
	--text="Place the first photo on the scanner and click OK" \
	--ok-label="OK" \
  --cancel-label="Quit"                                       │

# Quit
if [ ! $? = 0 ]; then
	exit 0
fi 


# Repeat scan until user cancels or quits
while true; do

	# Execute scan
	scanimage \
		--device-name="$SCANNER" \
	#	--compression=JPEG \
	#	--jpeg-quality=0 \
		--progress
		--resolution=600 \
		--format=pnm \
		--mode=color \
		> $FOLDER/$(date +%s).pmm 
	#| convert \
	#	-rotate 270 \
	#	tiff:- $FOLDER/$(date +%s).jpg
	
	# Scan failed
	if [ $? = 1 ]; then
		zenity --question \
			--title="Scan Failed" \
			--text="That photo didn't scan!  What do you want to do? " \
			--ok-label="Try again" \
			--cancel-label="Give up"
		if [ ! $? = 0 ]; then
			# Give up
			exit 1
		fi

	# Scan succeeded
	else

		# Scan again?
		zenity --question \
			--title="Scan Completed" \
			--text="Photo was saved in $FOLDER\nNow what? " \
			--ok-label="Scan another" \
			--cancel-label="Quit"
		
		# No			
		if [ ! $? = 0 ]; then
			exit 0
		fi
	fi
	
done;
