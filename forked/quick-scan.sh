#!/bin/bash
# Quick scan: a script to obtain a PNG 300ppi scan on your home folder.
# Configure: change the device name (line 11) with your scanner ID running: scanimage -L
# Dependencies: sane and libsane to scan (line 11) , imagemagick for cleaning (line 13), and notify-send for pretty D.E. notification (line 16).
# License: CC-0; author <info@davidrevoy.com>

version=$(date +%Y-%m-%d_%Hh%M%S)

touch /tmp/"$version"_scanner.tiff

scanimage --device genesys:libusb:002:012 --resolution 300 --mode Color --format=tiff > /tmp/"$version"_scanner.tiff

convert /tmp/"$version"_scanner.tiff -units PixelsPerInch -strip -interlace Plane -density 300 -colorspace sRGB -background white -alpha remove -define png:compression-strategy=3 -define png:color-type=2 -define png:compression-level=9 $HOME/"$version"_scanner.png

if [ -f $HOME/"$version"_scanner.png ]; then
  notify-send -i $HOME/"$version"_scanner.png "Scanned : "$version"_scanner.png"
fi

if [ -f /tmp/"$version"_scanner.tiff ]; then
  rm /tmp/"$version"_scanner.tiff
fi
 
# End