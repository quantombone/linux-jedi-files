#This script will aliases from the current directory into the home directory

#Get the current directory
DIR=`pwd`

#Make the aliases
ln -s ${DIR}/.mycolors ~/.mycolors
ln -s ${DIR}/.zshrc ~/.zshrc
ln -s ${DIR}/.emacs ~/.emacs
ln -s ${DIR}/.screenrc ~/.screenrc
