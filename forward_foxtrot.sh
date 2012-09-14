#!/bin/sh
#Forward port 5910 from foxtrot (which is running VNC server with -localhost flag) to localhost port 
#5901 over SSH so that localhost:1 will be good for VNC
#https://github.com/quantombone/linux-jedi-files/blob/master/forward_foxtrot.sh

echo "After typing foxtrot pw, just do xvnc4viewer :1 and use vnc password"
ssh -L5901:localhost:5910 tomasz@foxtrot.csail.mit.edu
