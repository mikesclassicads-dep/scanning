#!/bin/bash
# This will steal focus and make the Zenity dialog box always-on-top (aka. 'above').
 
$(sleep 1 && wmctrl -a Information -b add,above)&
$(zenity --info --text="T")
