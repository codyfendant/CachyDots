function fish_user_key_bindings

    # Bind Ctrl + s to our new custom toggle function
    bind \cs begin-selection

    # Ctrl + Shift + S to end-selection
    bind \es end-selection

    # Bind Ctrl + x to clear screen
    bind \cx clear-commandline

    # Bind Ctrl + r to reset (clear / wipe) terminal
    bind \cr clear-screen

    # Bind Alt + r to completely reload/reload Fish config
    bind \er 'exec fish; commandline -f repaint'

    # Bind Ctrl + z to suspend current commandline entry
    bind \cz 'commandline -f cancel'

    # Bind Ctrl + Shift + z to resume suspended process screen
    bind \cZ 'commandline -f repaint'

    # Bind Alt + z to undo
    bind \ez 'commandline -f undo'

    # Bind Alt + Shift + z to redo
    bind \eZ 'commandline -f redo'

    ## Bind Alt + p fzf running process search
    #bind \ep _fzf_search_processes
    #
    ## Bind Alt + h to fzf history search
    #bind \eh fzf-history-widget
    #
    ## Bin Alt + v to fzf variable search 
    #bind \ev '_fzf_search_variables (set --show | psub) (set --names | psub)'
    #
    bind \ef fzf-file-widget

    # Accept only the next word of the suggestion instead of the whole line
    # Ctrl + Right Arrow or Alt + right arrow
    bind \e\[1\;5C forward-word
    # Or an easier alternative modifier if your terminal supports it:
    bind alt-right forward-word

    # Open current command line buffer in your default editor ($EDITOR)
    # Ctrl + e
    bind \ce edit_command_buffer

    # Alt + Up Arrow: Move up to the parent directory
    bind \e\[1\;3A 'cd ..; commandline -f repaint'

    # Alt + Left Arrow: Move back in directory history
    bind \e\[1\;3D 'dirh_pop; commandline -f repaint'

    bind \cp _fish_ai_autocomplete_or_fix

    bind ctrl-space _fish_ai_codify_or_explain

    # fzf_configure_bindings --directory=alt-d --variables=alt-v --history=alt-h --processes=alt-p --variables=alt-v

end
