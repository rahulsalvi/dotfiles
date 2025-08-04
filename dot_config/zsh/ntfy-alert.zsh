# https://docs.ntfy.sh/examples/#terminal-notifications-for-long-running-commands
alert() {
    local exit_status=$?
    local status_icon="$([ $exit_status -eq 0 ] && echo magic_wand || echo warning)"
    local last_command=$(history | tail -n1 | sed -e 's/^[[:space:]]*[0-9]\{1,\}[[:space:]]*//' -e 's/[;&|][[:space:]]*alert$//')

    curl -s -X POST "https://ntfy.ipn.rahulsalvi.com/terminal-alerts" \
        -H "Authorization: Bearer $token" \
        -H "Title: Terminal" \
        -H "X-Priority: 3" \
        -H "Tags: $status_icon" \
        -d "Command: $last_command (Exit: $exit_status)" \
        -o /dev/null
}
