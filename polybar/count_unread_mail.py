from os import listdir
from os.path import isfile, exists, join
from sys import argv
import sys


def msg_is_unread(msg):
    # get the flags from the filename (follows ":2,")
    s = msg.split(":2,")
    if len(s) > 1:
        flags = s[1]
        # "S" indicates the message has been seen
        if not "S" in flags:
            return True
    return False


def main():
    if len(argv) != 2:
        print("!")
        return 0
    count = 0
    paths = argv[1].split(' ')
    for path in paths:
        for ext in ["cur", "new"]:
            full_path = join(path, ext)
            if exists(full_path):
                msgs = [
                    f for f in listdir(full_path) if isfile(join(full_path, f))
                ]
                count += sum(list(map(msg_is_unread, msgs)))
    print(count)
    return 0 if count > 0 else 1


if __name__ == "__main__":
    sys.exit(main())
