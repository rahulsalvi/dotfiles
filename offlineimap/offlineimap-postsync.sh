#!/usr/bin/env zsh

mail_location="${HOME}/Mail"
notify_location="${HOME}/Mail/.notified"

new_mail=$(find $mail_location -regex '.*/INBOX/new/.*')
if [[ -n "$new_mail" ]]; then
    while IFS= read -r line ; do
        stripped=$(echo ${line#$mail_location} | tr / _)
        if [[ ! -e "$notify_location/$stripped" ]]; then
            from=$(${HOME}/.offlineimap/get_mail_from $line)
            subject=$(${HOME}/.offlineimap/get_mail_subject $line)
            notify-send -i mailspring "${from}" "${subject}"
            ln -s $line $notify_location/$stripped
        fi
    done <<< "$new_mail"
fi

setopt null_glob
rm -f -- ${notify_location}/*(-@D)
