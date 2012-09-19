#This is my .zshrc file which I use on *nix servers at CMU and MIT, as well as my local laptops
# Tomasz Malisiewicz (malist@gmail.com / tomasz@cmu.edu / tomasz@csail.mit.edu)
# It is used on my CMU *nix SCS facilitized machines, *nix local machines, and macbook laptops
# Now on github (https://github.com/quantombone/linux-config-files)

umask 0002
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

#get the short hostname
HOSTBASE=${HOST%%.*}
export PYTHONPATH=/opt/local/lib/python2.5/site-packages

## set up machine-specific variables
if [[ $VENDOR == "apple" ]]; then
    
    #fink stuff goes here
    #deprecated due to switch to macports in ~2010
    #if [ -d "/sw/bin/" ]; then
    #    # Control will enter here if $DIRECTORY exists
    #    source /sw/bin/init.sh
    #fi
    
    #MacPorts puts stuff here
    export PATH=$PATH:/opt/local/bin/

    #Setup emacs alias
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
    #alias emacsclient='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
    
    #Use ls which allows coloring
    alias ls='/opt/local/bin/gls --color=auto -h'

    #alias matlab='export DISPLAY=:0.0 && /Applications/MATLAB74/bin/matlab -nodesktop -nosplash'
    alias matlab='/Applications/MATLAB_R2011a.app/bin/matlab -nodesktop -nosplash'

    export PATH=$PATH:/usr/texbin/

    eval `/opt/local/bin/gdircolors -b ~/linux-jedi-files/.mycolors`
else
    #for being at CMU
    #export CVSROOT=/afs/cs.cmu.edu/user/tmalisie/private/cvsroot
    
    #enable colored ls always!
    alias ls='ls -Fh --color=tty -pX'
    #alias matlab='matlab -nodesktop -nosplash'


    #use my custom dircolors
    eval `dircolors -b ~/linux-jedi-files/.mycolors`


fi


export CVS_RSH=/usr/bin/ssh
export EDITOR=nano
export SHELL=/bin/zsh

#set up some canonical colors for the rest
g_green=$'%{\e[0;32m%}'
fg_blue=$'%{\e[0;34m%}'
fg_cyan=$'%{\e[0;36m%}'
fg_red=$'%{\e[0;31m%}'
fg_brown=$'%{\e[0;33m%}'
fg_purple=$'%{\e[0;35m%}'

fg_light_gray=$'%{\e[0;37m%}'
fg_dark_gray=$'%{\e[1;30m%}'
fg_light_blue=$'%{\e[1;34m%}'
fg_light_green=$'%{\e[1;32m%}'
fg_light_cyan=$'%{\e[1;36m%}' 
fg_light_red=$'%{\e[1;31m%}'
fg_light_purple=$'%{\e[1;35m%}'
fg_no_colour=$'%{\e[0m%}'

fg_white=$'%{\e[1;37m%}'
fg_black=$'%{\e[0;30m%}'
fg_undo=$'%{\e[0m%}'

#Setup colored prompt variable
#TJM: 08/2009 works in emacs actually    
PS1="[%n@${fg_light_red}%m${fg_undo}]%~%# "

# good guide for changing things found at found at:
# http://www.ibiblio.org/pub/Linux/docs/HOWTO/other-formats/html/Xterm-Title.html.gz
case $TERM in (xterm*|rxvt)
    precmd () { print -Pn "\e]0;%n@%m: %~\a" }
    preexec () { print -Pn "\e]0;%n@%m: $1\a" }

    #using $1 instead of $* doesn't give me the repeat problem
    #preexec () { print -Pn "\e]0;%n@%m: $*\a" }
    #;;
esac


#do the fancy interaction with titlebars only if we are in a non-emacs 
#shell and inside a screen session

if [[ $USING_SCREEN == "yes" ]] && [[ $TERM != dumb ]]; then
  # use the current user as the prefix of the current tab title (since that's
  # fairly important, and I change it fairly often)
  TAB_TITLE_PREFIX='""'
  # when at the shell prompt, show a truncated version of the current path (with
  # standard ~ replacement) as the rest of the title.
  TAB_TITLE_PROMPT='`echo $PWD | sed "s/^\/Users\//~/;s/^~$USER:/~/;s/\/..*\//\/...\//"`'
  #TAB_TITLE_PROMPT='`echo $PWD`'
  # when running a command, show the title of the command as the rest of the
  # title (truncate to drop the path to the command)
  TAB_TITLE_EXEC='$cmd[1]:t'
 
  # use the current path (with standard ~ replacement) in square brackets as the
  # prefix of the tab window hardstatus.
  TAB_HARDSTATUS_PREFIX='"[`echo $PWD(:t) | sed "s/^\/Users\//~/;s/^~$USER/~/"`] "'
  #TAB_HARDSTATUS_PREFIX='"[`echo $PWD `]"'

  # when at the shell prompt, use the shell name (truncated to remove the path to
  # the shell) as the rest of the title
  TAB_HARDSTATUS_PROMPT='$SHELL:t'
  # when running a command, show the command name and arguments as the rest of
  # the title
  TAB_HARDSTATUS_EXEC='$cmd'

 function screen_set()
  {  
    #  set the tab window title (%t) for screen
    #print -nR $'\033k'`hostname`:$1$'\033'\\\
    print -nR $'\033k'$HOSTBASE:$1$'\033'\\\
    #todo!!!
    #try to get different colored tabs for different hosts

    # set hardstatus of tab window (%h) for screen
    #print -nR $'\033]0;'`whoami`@`hostname`: $2$'\a'
    print -nR $'\033]0;'$USER@$HOST: $2$'\a'
  }

  # called by zsh before executing a command
  function preexec()
  {
    local -a cmd; cmd=(${(z)1}) # the command string
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_EXEC"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_EXEC"
    screen_set $tab_title $tab_hardstatus

  }
  # called by zsh before showing the prompt
  function precmd()
  {
    eval "tab_title=$TAB_TITLE_PREFIX$TAB_TITLE_PROMPT"
    eval "tab_hardstatus=$TAB_HARDSTATUS_PREFIX$TAB_HARDSTATUS_PROMPT"
    screen_set $tab_title $tab_hardstatus

  }

  #precmd () { screen_set $tab_title $tab_hardstatus }
  #preexec () { screen_set $tab_title $tab_hardstatus }


fi

# enable colored completions
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
autoload -U compinit
compinit

# Menu for KILL (just type kill space tab to see list of processes to kill)
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

#alias Ea='screen -X escape ^a^a'
#alias Ex='screen -X escape ^x^x'
#emacs server stuff goes here:  not using this though
# e() {
#     local FILE=$1
    
#     if [[ -z $FILE ]]; then
#         echo "Missing filename"
#         return
#     fi
    
#     if [ $FILE[0] != "/" -o $FILE[0] = "~" ]
#     then
#         FILE="$PWD/$FILE"
#     fi
    
#     if [[ -z $2 ]]; then
#         emacsclient -n $FILE
#     else
#         emacsclient -e "(find-file-other-frame \"$FILE\")"
#     fi
# }

# ef() {
#     e $1 "yes"
# }

##fix stuff here???
if [ "$TERM" = "dumb" ]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  #TJM: 08/2009 doesnt need this now?
  #unfunction precmd
  #unfunction preexec
  #PS1='$ '
fi

#if [ "$TERM" = "eterm-color" ]
#then
#  unsetopt zle
#fi

#add some more paths for git and such
#NOTE: this was only on the CMU machines
#NOTE: This gave an error on Mountain Lion
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib64/

export PATH=/usr1/users/tmalisie/git/bin/:~/bin/:${PATH}
#export PATH=~/install/bin:${PATH}:/usr1/users/tmalisie/git/bin/:~/install/bin/:~/bin/:~/video-adapt/scripts/

umask 0002

