#!/usr/bin/env python

import json
import os
import sys

apps_file = os.path.join(os.getenv("HOME"), ".config/rofi/apps.json")
default_terminal = "kitty"

def print_apps(apps):
    for app in sorted(apps.keys()):
        print(app)

def run_app(apps, app):
    opts = apps.get(app)
    if opts is None:
        return
    cmd = opts.get("command", app)
    term = opts.get("terminal", False)
    if term:
        termcmd = os.getenv("TERMCMD", default_terminal)
        directory = opts.get("directory")
        if directory:
            termcmd = termcmd + " --directory " + directory
        cmd = termcmd + " " + cmd
    cmd = cmd + " >/dev/null 2>&1 &"
    os.system(cmd)

def main(argv):
    if os.path.exists(apps_file):
        with open(apps_file, "r", encoding="utf-8") as file:
            apps = json.load(file)
            match len(argv):
                case 1:
                    print_apps(apps)
                case 2:
                    run_app(apps, argv[1])
                case _:
                    pass
    return 0

if __name__ == "__main__":
    sys.exit(main(sys.argv))
