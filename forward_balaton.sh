#!/bin/sh
#Forword port 5909 from balaton (which is running VNC server) to localhost port 
#5901 so that localhost:1 will be good for VNC
echo "After typing balaton pw, just do xvnc4viewer :1 and use vnc password"
ssh -L5901:balaton:5909 tmalisie@balaton
