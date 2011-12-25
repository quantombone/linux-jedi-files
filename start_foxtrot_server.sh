#!/bin/sh

#Here is the script to start a vnc server which only works on
#localhost, this means we must be using the -localhost flag and using SSH port forwarding

VNC_GEOMETRY=2560x1600
VNC_PORT=10
longjob vnc4server :${VNC_PORT} -geometry ${VNC_GEOMETRY} -localhost
echo "Just started VNC server with screen resolution " ${VNC_GEOMETRY} " on port " ${VNC_PORT}
