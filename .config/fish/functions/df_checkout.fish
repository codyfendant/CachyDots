for file in (dotfiles checkout 2>&1 | grep -E "^\s" | awk '{print $1}')
    mkdir -p (dirname ~/.config-backup/$file)
    mv ~/$file ~/.config-backup/$file
end
dotfiles checkout
