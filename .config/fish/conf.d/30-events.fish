# Trigger right after a command executes
function __notify_long_running_cmd --on-event fish_postexec
    # Example: notify if a command took longer than 10 seconds
    if test $CMD_DURATION -gt 10000
        echo (set_color yellow)"[Finished in "(math $CMD_DURATION / 1000)"s]"
    end
end

# Trigger on shell exit
function __on_fish_exit --on-event fish_exit
    # Cleanup temporary files or save state
end
