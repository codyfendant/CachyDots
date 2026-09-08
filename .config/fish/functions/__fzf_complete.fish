function __fzf_complete
    
    set -l token (commandline -ct)

    # optional: set $fzf_complete_opts for extra fzf flags
    set -l selected (
        complete --do-complete (commandline -b) |
        fzf --query="$token" --height=~40% --layout=reverse $fzf_complete_opts
    )

    set -l completion (string split \t -- "$selected")[1]

    if test -n "$completion"
        commandline -t -- $completion
    end

    commandline -f repaint
end