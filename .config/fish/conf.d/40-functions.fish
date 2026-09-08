# Better history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (string trim -r -c '/' $argv[1])
        set to $argv[2]
        command cp -r $from $to
    else
        command cp $argv
    end
end

# mkcd DIR
function mkcd
    mkdir -p $argv[1]; and cd $argv[1]
end

# Extract archives
function extract
    set file $argv[1]
    if test -f $file
        switch $file
            case '*.tar.bz2'
                tar xjf $file
            case '*.tar.gz'
                tar xzf $file
            case '*.bz2'
                bunzip2 $file
            case '*.rar'
                unrar x $file
            case '*.gz'
                gunzip $file
            case '*.tar'
                tar xvf $file
            case '*.tbz2'
                tar xjf $file
            case '*.tgz'
                tar xzf $file
            case '*.zip'
                unzip $file
            case '*.Z'
                uncompress $file
            case '*.7z'
                7z x $file
            case '*'
                echo "'$file' cannot be extracted via extract()"
        end
    else
        echo "'$file' is not a valid file"
    end
end
################
##yazi cd onexit
###############
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end
