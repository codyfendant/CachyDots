# Default applications
set -gx GEMINI_API_KEY "AQ.Ab8RN6Ll0JHWB05rrGJsWYn3EOuu9yfU7w8mg1SrrWsFj_J-7g"
set -gx MANAGERS aur pacman yay flatpak homebrew
set -gx FZF_THEME catppuccin-mocha
set -gx CLICOLOR 1
set -gx EDITOR nvim
set -gx VISUAL nvim
set -Ux fifc_editor
set -U fifc_fd_opts --hidden
# Add paths to PATH (fish_add_path handles duplicates automatically)
fish_add_path $HOME/.local/bi

set -gx PYENV_ROOT $HOME/.pyenv
if test -d $PYENV_ROOT/bin
    fish_add_path $PYENV_ROOT/bin
end

# Ruby rbenv Setup
if test -d $HOME/.rbenv/bin
    fish_add_path $HOME/.rbenv/bin
end
if type -q rbenv
    rbenv init - | source
end

# Lacy Shell bin
if test -d /home/raidr/.lacy/bin
    fish_add_path /home/raidr/.lacy/bin
end

# Cargo bin path
if test -d /home/raidr/.cargo/bin
    fish_add_path /home/raidr/.cargo/bin
end

if test -d $HOME/.local/bin/
    fish_add_path /home/raidr/.local/bin/
end

# Initialize FZF
if type -q fzf
    fzf --fish | source
end

# Initialize Zoxide
if type -q zoxide
    zoxide init fish | source
end

# Run fastfetch
#if type -q fastfetch
#    fastfetch
#end

set -gx sudope_sequence \eS

set -gx MANPAGER "less -R --use-color -Dd+r -Du+b"
set -gx MANROFFOPT -c
