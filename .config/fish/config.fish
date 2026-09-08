# ~/.config/fish/config.fish
# Source functions configuration
scheme set molokai
# Source user keybinds
source ~/.config/fish/user_key_binds.fish

# opencode
#fish_add_path /home/cody/.opencode/bin

##oh-my-posh init fish --config ~/.wholespace.omp.json | source

# Added by Antigravity CLI installer
set -gx PATH "/home/raidr/.local/bin" $PATH

oh-my-posh init fish --config ~/.posh.omp.toml | source
##starship init fish | source
##enable_transience

set -gx WAYLAND_DISPLAY wayland-1
set -gx XDG_CONFIG_HOME $HOME/.config/
