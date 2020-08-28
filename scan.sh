#script to scan images
#set variables
$DPI=
$FOURDIGITOUTNUMBER
$OUTPUTNAME
#add "read" command to set image prefix and suffix
#add "read" command to set dpi
#add "wait" or "sleep" command before setting a key press that will go ahead with next scan
#this command works as expected
scanimage --format=pnm --mode=color --progress --resolution=100 > set1-tsep19470412-test.ppm
#is command I would likely use
scanimage --format=pnm --mode=color --progress --resolution=600 > set2-tsep19470412-XXXX.ppm
