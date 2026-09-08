function ff
    set search_dir (test -n "$argv[1]"; and echo "$argv[1]"; or echo ".")

    # File extensions that should open in Neovim
    set code_extensions \
        txt md markdown rst \
        c cpp cc cxx h hpp hxx \
        js jsx ts tsx json jsonc \
        py pyx pyi rb go rs java php \
        html htm css scss sass less \
        xml yaml yml toml ini conf config \
        sh bash zsh fish vim lua sql \
        r R pl pm swift kt scala clj hs elm \
        ex exs erl f90 f95 f03 tex bib org \
        dockerfile makefile log csv tsv \
        proto graphql svelte vue dart nim zig \
        crystal jl

    # Use fzf to select file/directory
    set selected (find $search_dir -type f -o -type d 2>/dev/null | \
        fzf --height=40% \
            --layout=reverse \
            --border \
            --preview='if test -d {}; ls -la {}; else if test -f {}; head -50 {}; end; end' \
            --preview-window=right:50%:wrap \
            --header="Enter: open, Tab: toggle preview" \
            --bind="tab:toggle-preview")

    # Exit if nothing selected
    if test -z "$selected"
        return 0
    end

    # Handle the selection
    if test -d "$selected"
        # It's a directory - navigate to it
        cd "$selected" && pwd

    else if test -f "$selected"
        # It's a file - check if it should open in Neovim
        set ext (string split -r -m1 . "$selected")[2]
        set basename_file (basename "$selected")

        # Check if extension is in code_extensions or it's a common text file without extension
        if contains (string lower "$ext") $code_extensions
            nvim "$selected"

        else if test -z "$ext"
            # Check for common files without extension
            if echo "Makefile Dockerfile Rakefile Gemfile Procfile LICENSE README CHANGELOG TODO INSTALL" | grep -q "$basename_file"
                nvim "$selected"
                # Check if it's a text file
            else if file "$selected" 2>/dev/null | grep -q text
                nvim "$selected"
            else
                xdg-open "$selected" 2>/dev/null &
            end

        else
            # Use xdg-open for other files (images, PDFs, etc.)
            xdg-open "$selected" 2>/dev/null &
        end

    else
        echo "Error: Selected item doesn't exist or is not a regular file/directory"
        return 1
    end
end
