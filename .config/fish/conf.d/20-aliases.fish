#Directory Shortcuts
alias home='cd ~'
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias bin='cd /bin/'
alias lbind='cd /usr/local/bin/'
alias confd='cd ~/.config/'
alias fishd='cd ~/.config/fish/'
alias kittyd='cd ~/.config/kitty'
alias nvimd='cd ~/.confif/nvim/'
alias nvplugd='cd ~/.config/nvim/lua/plugins/'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias .....='cd ../../../..'

#LS(D) Aliases
alias l=lsd
alias la='lsd -a'
alias ld='lsd -d'
alias ll='lsd -l'
alias lla='lsd -la'
alias ls=lsd
alias lsl='lsd -l'
alias lsr='lsd -R'
alias lt='lsd --tree'
alias ltd='lsd --tree --depth'

#Configuration Shortcuts
alias aliascf='nvim ~/.config/fish/conf.d/20-aliases.fish'
alias kittycf='nvim ~/.config/kitty/kitty.conf'
alias fishcf='nvim ~/.config/fish/config.fish'
alias fienvs='nvim ~/.config/fish/conf.d/00-env.fish'
alias fievals='nvim ~/.config/fish/conf.d/10-evals.fish'
alias fievents='nvim ~/.config/fish/conf.d/30-events.fish'
alias footconf='nvim ~/.config/foot/foot.ini'

#Pacman / Yay / Pikaur Aliases
alias rmlck="sudo rm /var/lib/pacman/db.lck"
alias pac='sudo pacman'
alias paci='sudo pacman -S'
alias pacls='pacman -Q | grep'
alias pacs='pacman -Ss'
alias pkgls="pacman -Qqe | xargs pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $3$4, name}' | sort -hr"
alias yayi='yay -S'
alias yays='yay -Ss'
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages
alias mirror="sudo cachyos-rate-mirrors"

alias pclean='sudo pacman -Rs $(pacman -Qtdq)'

alias rmcache='sudo rm -rf /var/cache/pacman/pkg' # Clear pacman cached packages

alias sortday="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias sortsz="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB

alias pacup='pikaur -Syu '

# Pikaur Aliases
alias piki='pikaur -S --needed'
alias piks='pikaur -q'
alias piku='pikaur -Syu'
alias yeet='pikaur -Rns'
alias clean='pikaur -Sc'
alias gitup='pikaur -Sua --devel --needed'
alias chkup='checkupdates ; pikaur -Qua 2>/dev/null'
alias pik='pikaur'

# Paur Aliases
#alias pari='paur -S --needed'
#alias pars='paur -Ss'
#alias pard='paur -Rns'
#alias paru='paur -Syu'

#System/Device Aliases
alias lsblk='lsblk -o NAME,SIZE,FSTYPE,UUID,MOUNTPOINTS,PARTLABEL'
alias restart-net='sudo systemctl restart network-manager'
alias hw='hwinfo --short' # Hardware Info
alias jctl="journalctl -p 3 -xb"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias grubup="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias kitrel='kill -SIGUSR1'
alias mkexec='chmod +x'
alias fixaudio='systemctl --user restart pipewire pipewire-pulse wireplumber'

#File Management Aliases
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -rfI'
alias tarnow='tar -czvf '
alias untar='tar -zxvf '
alias wget='wget -c '

#Git Aliases
alias g=git
alias gclo='git clone'

#####################
## GREP  SHORTCUTS ##
#####################
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#####################
## NVIM SHORTCUTS ###
#####################
alias nano=nvim
alias nv=nvim
alias nvplug='nvim ~~/.config/nvim/lua/plugins/temp.lua'
alias kick='NVIM_APPNAME=nvim-kickstart nvim'

#####################
### Shell Aliases ###
#####################
alias hist=history
alias r='exec fish'
alias sedit=sudoedit
alias su=sudo

#####################
##### SHORTCUTS #####
#####################
alias ascl='ascii-colorizer --file'
alias fig='figlet -f'
alias mc=micro
alias t=touch
alias ai='aichat'
alias noc='noctalia'
alias n='nvim'
alias q='exit'
alias h='history'
alias c='clear'
alias shutdown='systemctl poweroff'
alias ktfetch='kotofetch'
alias pipv='python -m venv venv && python -m venv venv && source venv/bin/activate'
alias noctalia-restart='noctalia list  --json | jq .[].pid | xargs -r ; noctalia -d'
alias systemls='systemctl list-units --type=service --state=running'

#FastFetch Aliases
alias fast=fastfetch
alias ffc='fastfetch --config'
alias ffcf='nvim ~/.config/fastfetch/config.jsonc'

###########################
##### WEZTERM ALIASES #####
###########################
alias wezcf='nvim ~/.config/wezterm/wezterm.lua'

##########################
####### ST ALIASES #######
##########################
alias strl='xrdb -merge ~/.Xresources && pidof st | xargs kill -s USR1'

##########################
##### DOTFILE REPO SC#####
##########################
alias dots='git --git-dir=$HOME/.cachydots/ --work-tree=$HOME'
alias dfpush='git --git-dir=$HOME/.cachydots/ --work-tree=$HOME push -u origin main'
alias dfcommit='git --git-dir=$HOME/.cachydots/ --work-tree=$HOME commit -m'
alias dfadd='git --git-dir=$HOME/.cachydots/ --work-tree=$HOME add'
alias dfcheck='git --git-dir=$HOME/.cachydots/ --work-tree=$HOME chekout'
alias dfstatus='git --git-dir=$HOME/.cachydots/ --work-tree=$HOME status'

#Abbrviation Aliases
abbr -a conf --position anywhere '~/.config/'
abbr -a gc --position command 'git clone'
abbr -a gp --position anywhere '| grep '
abbr -a ulb --position anywhere /usr/local/bin/
abbr -a y --position anywhere 'yes | '
abbr -a gr --position anywhere '| grep'
##abbr --add h --position anywhere -- --help
abbr -a alias --position command 'alias | grep '
abbr -a cpcmd --position anywhere '| wl-copy'
abbr -a ddhelp --position command 'dd if= of= bs=4M oflag=direct conv=fdatasync status=progress'
