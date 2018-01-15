#!/usr/bin/env sh

notmuch new

newmail=$(find ~/Mail -regex .*/new/.*)
while IFS= read -r line ; do
    from=$(ag "^From" $line | sed 's/.*: //')
    subject=$(ag "^Subject" $line | sed 's/.*: //')
    notify-send -i mailspring "$from" "$subject"
done <<< "$newmail"
