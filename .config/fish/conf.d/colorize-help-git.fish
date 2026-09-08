# colorize-help.fish - Colorize command help output using bat in Fish shell
# Converted from colorize-help.zsh

# Detect bat or batcat executable
set -l bat_cmd
if type -q bat
    set bat_cmd bat
else if type -q batcat
    set bat_cmd batcat
end

if test -n "$bat_cmd"
    # Helper function to pipe help output into bat with syntax highlighting
    function __colorize_help --description "Colorize help text output with bat"
        set -l bat_cmd
        if type -q bat
            set bat_cmd bat
        else if type -q batcat
            set bat_cmd batcat
        else
            cat
            return
        end

        $bat_cmd --color=always -pplhelp $argv
    end

    # List of help flags to auto-colorize
    set -l help_flags \
        --help \
        --help-list \
        --help-hidden \
        --help-list-hidden \
        -help \
        -help-list \
        -help-hidden \
        -help-list-hidden \
        '-\?' \
        '-?' \
        -ccs.help \
        --longhelp \
        --fullhelp \
        --help-all \
        --help-gapplication \
        --help-gtk

    for flag in $help_flags
        abbr -a --position anywhere -- $flag "$flag 2>&1 | __colorize_help"
    end
end

# Event listener for plugin uninstallation (e.g. fisher / omf)
function _colorize_help_uninstall --on-event colorize_help_uninstall
    set -l help_flags \
        --help \
        --help-list \
        --help-hidden \
        --help-list-hidden \
        -help \
        -help-list \
        -help-hidden \
        -help-list-hidden \
        '-\?' \
        '-?' \
        -ccs.help \
        --longhelp \
        --fullhelp \
        --help-all \
        --help-gapplication \
        --help-gtk

    for flag in $help_flags
        abbr --erase -- $flag 2>/dev/null
    end
    functions --erase __colorize_help
    functions --erase _colorize_help_uninstall
end
