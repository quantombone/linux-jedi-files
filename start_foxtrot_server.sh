#!/bin/sh

#Here is the script to start a vnc server on a linux server which only takes connections from
#localhost, this means we must be using the -localhost flag and using SSH port forwarding
#https://github.com/quantombone/linux-jedi-files/edit/master/start_foxtrot_server.sh

#Geometry currently set so that workspace is full screen on iMac 27 inch display
VNC_GEOMETRY=2560x1600

#Setting port to 10 so hopefully it doesn't conflict with others
VNC_PORT=10

#Use longjob so the process stays alive longer?
longjob vnc4server :${VNC_PORT} -geometry ${VNC_GEOMETRY} -localhost

echo "Just started VNC server with screen resolution " ${VNC_GEOMETRY} " on port " ${VNC_PORT}
