#!/usr/bin/env zsh

notmuch new

mail_location="${HOME}/Mail"
notify_location="${HOME}/Mail/.notified"

new_mail=$(find $mail_location -regex '.*/INBOX/new/.*')
if [[ -n "$new_mail" ]]; then
    while IFS= read -r line ; do
        stripped=$(echo ${line#$mail_location} | tr / _)
        if [[ ! -e "$notify_location/$stripped" ]]; then
            from=$(rg "^From" $line)
            subject=$(rg "^Subject" $line)
            notify-send -i mailspring "${from#From: }" "${subject#Subject: }"
            ln -s $line $notify_location/$stripped
        fi
    done <<< "$new_mail"
fi

setopt null_glob
rm -f -- ${notify_location}/*(-@D)
