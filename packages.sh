#!/usr/bin/env zsh

# Set sources and destinations
typeset -A PACKAGESRCS
PACKAGESRCS["ls /Applications"]="applications"
PACKAGESRCS["port installed requested"]="macports-requested"
PACKAGESRCS["port installed"]="macports-all"
PACKAGESRCS["pip-2.7 list"]="pip27"
PACKAGESRCS["pip-3.5 list"]="pip35"
PACKAGESRCS["gem list"]="RubyGems"
PACKAGEDEST=~/Dropbox/config/OSX/$HOST

setopt localoptions shwordsplit
for command in "${(@k)PACKAGESRCS}"
do
    ${command:gs/\"/} > $PACKAGEDEST/$PACKAGESRCS[$command] 2>/dev/null
done
