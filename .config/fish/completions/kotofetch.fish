# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_kotofetch_global_optspecs
	string join \n c/config= horizontal-padding= vertical-padding= width= translation= translation-color= quote-color= bold= border= rounded-border= border-color= source= modes= index= seed= centered= dynamic= furigana-position= animation= animation-duration-ms= h/help V/version
end

function __fish_kotofetch_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_kotofetch_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_kotofetch_using_subcommand
	set -l cmd (__fish_kotofetch_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c kotofetch -n "__fish_kotofetch_needs_command" -s c -l config -d 'Path to config file (TOML). Defaults to ~/.config/kotofetch/config.toml' -r -F
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l horizontal-padding -d 'Horizontal padding' -r
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l vertical-padding -d 'Vertical padding' -r
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l width -d 'Override width (0 = automatic)' -r
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l translation -d 'Choose translation modes (comma-separated): none, english, romaji, furigana' -r -f -a "none\t''
english\t''
romaji\t''
furigana\t''"
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l translation-color -d 'Translation color (hex like #888888 or named)' -r
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l quote-color -d 'Quote color (hex like #888888 or named)' -r
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l bold -d 'Make Japanese text bold' -r -f -a "true\t''
false\t''"
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l border -d 'Draw a border around the quote' -r -f -a "true\t''
false\t''"
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l rounded-border -d 'Is the border rounded?' -r -f -a "true\t''
false\t''"
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l border-color -d 'Border color (hex like #888888 or named)' -r
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l source -d 'Show quote source' -r -f -a "true\t''
false\t''"
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l modes -d 'Quote options' -r -F
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l index -d 'Choose a specific quote by index (0-based) for reproducible output' -r
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l seed -d 'Seed for random selection (0 = random by time)' -r
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l centered -d 'Center text' -r -f -a "true\t''
false\t''"
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l dynamic -d 'Dynamic re-centering text' -r -f -a "true\t''
false\t''"
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l furigana-position -d 'Show furigana above or below the Japanese text' -r -f -a "above\t''
below\t''"
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l animation -r -f -a "none\t''
typewriter\t''
scramble\t''
slide\t''"
complete -c kotofetch -n "__fish_kotofetch_needs_command" -l animation-duration-ms -r
complete -c kotofetch -n "__fish_kotofetch_needs_command" -s h -l help -d 'Print help'
complete -c kotofetch -n "__fish_kotofetch_needs_command" -s V -l version -d 'Print version'
complete -c kotofetch -n "__fish_kotofetch_needs_command" -f -a "init" -d 'Import quotes from external sources'
complete -c kotofetch -n "__fish_kotofetch_needs_command" -f -a "completion" -d 'Output the completion script'
complete -c kotofetch -n "__fish_kotofetch_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and not __fish_seen_subcommand_from anki help" -s h -l help -d 'Print help'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and not __fish_seen_subcommand_from anki help" -f -a "anki" -d 'Import Anki decks via AnkiConnect'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and not __fish_seen_subcommand_from anki help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from anki" -l url -d 'AnkiConnect URL' -r
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from anki" -l deck -d 'Deck name(s) to import (repeatable; skips interactive deck picker)' -r
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from anki" -l japanese-field -d 'Field to use as the Japanese text' -r
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from anki" -l translation-field -d 'Field to use as the English translation' -r
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from anki" -l furigana-field -d 'Field containing Anki furigana markup (used if japanese field has none)' -r
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from anki" -l romaji-field -d 'Field to use as the romaji (romanized) reading' -r
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from anki" -l source-field -d 'Field to use as the source label' -r
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from anki" -l output-dir -d 'Output directory (default: ~/.config/kotofetch/quotes/)' -r -F
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from anki" -l yes -d 'Skip all prompts; use heuristic field mapping and overwrite existing files'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from anki" -s h -l help -d 'Print help'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from help" -f -a "anki" -d 'Import Anki decks via AnkiConnect'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand init; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand completion" -s h -l help -d 'Print help'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand help; and not __fish_seen_subcommand_from init completion help" -f -a "init" -d 'Import quotes from external sources'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand help; and not __fish_seen_subcommand_from init completion help" -f -a "completion" -d 'Output the completion script'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand help; and not __fish_seen_subcommand_from init completion help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c kotofetch -n "__fish_kotofetch_using_subcommand help; and __fish_seen_subcommand_from init" -f -a "anki" -d 'Import Anki decks via AnkiConnect'
