#First we kill currently running server
pkill OSXvnc-server
cd "/Applications/Vine Server.app/Contents/MacOS"
./OSXvnc-server -rfbauth pw -rfbport 5901 -localhost
