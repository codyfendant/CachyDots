# fzf.fish is only meant to be used in interactive mode. If not in interactive mode and not in CI, skip the config to speed up shell startup
if not status is-interactive && test "$CI" != true
    exit
end

# Because of scoping rules, to capture the shell variables exactly as they are, we must read
# them before even executing _fzf_search_variables. We use psub to store the
# variables' info in temporary files and pass in the filenames as arguments.
# This variable is global so that it can be referenced by fzf_configure_bindings and in tests
set --global _fzf_search_vars_command '_fzf_search_variables (set --show | psub) (set --names | psub)'

# Install the default bindings, which are mnemonic and minimally conflict with fish's preset bindings
fzf_configure_bindings

# Doesn't erase autoloaded _fzf_* functions because they are not easily accessible once key bindings are erased
function _fzf_uninstall --on-event fzf_uninstall
    _fzf_uninstall_bindings

    set --erase _fzf_search_vars_command
    functions --erase _fzf_uninstall _fzf_migration_message _fzf_uninstall_bindings fzf_configure_bindings
    complete --erase fzf_configure_bindings

    set_color cyan
    echo "fzf.fish uninstalled."
    echo "You may need to manually remove fzf_configure_bindings from your config.fish if you were using custom key bindings."
    set_color normal
end

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#C6C6C6,fg+:#C6C6C6,bg:#121212,bg+:#323437
  --color=hl:#88D7BA,hl+:#40EDAF,info:#afaf87,marker:#8CC85F
  --color=prompt:#74B2FF,spinner:#AE81FF,pointer:#F09479,header:#E65E72
  --color=border:#C6C6C6,separator:#F09479,preview-border:#AE81FF,preview-scrollbar:#C6C6C6
  --color=label:#88D7BA,query:#B2B2B2
  --border="rounded" --border-label=")f" --border-label-pos="1" --preview-window="border-rounded"
  --prompt="> " --marker=">" --pointer="◆" --separator="─"
  --scrollbar="│" --info="right"'

  fzf_configure_bindings --directory=alt-d --variables=alt-v --history=alt-h --processes=alt-p --variables=alt-v

