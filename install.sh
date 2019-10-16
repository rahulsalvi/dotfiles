#!/bin/sh

# INPUTS:
#   $SRC: source file relative to $PWD
#   $DST: destination file relative to $HOME

# expand src and dst
SRC=${PWD}/${SRC}
DST=${HOME}/${DST}
# make directory if it doesn't exist
mkdir -p "$(dirname "$DST")"
# delete old symlink if it existed
[ -h "${DST}" ] && rm "${DST}"
# save old copy of destination file if it existed
[ -f "${DST}" ] && mv "${DST}" "${DST}.save"
# create symlink from source to destination
ln -s "${SRC}" "${DST}"
