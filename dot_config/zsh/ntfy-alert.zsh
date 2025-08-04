# https://docs.ntfy.sh/examples/#terminal-notifications-for-long-running-commands
ntfy_alert() {
    local exit_status=$?
    local status_icon="$([ $exit_status -eq 0 ] && echo magic_wand || echo warning)"
    local last_command=$(echo $history[$HISTCMD] | sed 's/;.*//')

    curl -s -X POST "https://ntfy.ipn.rahulsalvi.com/terminal-alerts" \
        -H "Authorization: Bearer $token" \
        -H "Title: Terminal" \
        -H "X-Priority: 3" \
        -H "Tags: $status_icon" \
        -d "Command: $last_command (Exit: $exit_status)" \
        -o /dev/null
}
alias alert='ntfy_alert'
