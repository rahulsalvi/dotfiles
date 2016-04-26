import sys
import os
import subprocess
from enum import Enum

class Format:
    class Code(Enum):
        black   = 0
        red     = 1
        green   = 2
        yellow  = 3
        blue    = 4
        magenta = 5
        cyan    = 6
        white   = 7
        default = 9
    def __init__(self, fg, bg, fgbold=False, bgbold=False):
        self.fgval = self.Code[fg].value + 30
        self.bgval = self.Code[bg].value + 40
        if fgbold:
            self.fgval += 60
        if bgbold:
            self.bgval += 60
    def getEscapeSequence(self):
        return "%{\033["+str(self.fgval)+";"+str(self.bgval)+"m%}"


class Segment:
    def __init__(self, text, fmt):
        self.text = " " + text + " "
        self.fmt = fmt
    def getString(self, nextfmt):
        if nextfmt == None:
            if os.getenv('BACKGROUND') == 'light':
                bg = "107"
            else:
                bg = "100"
            return self.fmt.getEscapeSequence()+self.text+"%{\033["+str(self.fmt.bgval-10)+";"+bg+"m%}"+'\ue0b0'+"%{\033[0m%}"
        else:
            if self.fmt.bgval == nextfmt.bgval:
                if os.getenv('BACKGROUND') == 'light':
                    fg = "97"
                else:
                    fg = "90"
                return self.fmt.getEscapeSequence()+self.text+"%{\033["+fg+";"+str(nextfmt.bgval)+"m%}"+'\ue0b1'
            else:
                return self.fmt.getEscapeSequence()+self.text+"%{\033["+str(self.fmt.bgval-10)+";"+str(nextfmt.bgval)+"m%}"+'\ue0b0'

def resolve(segments):
    string = ""
    for i in range(len(segments)-1):
        string += segments[i].getString(segments[i+1].fmt)
    string += segments[-1].getString(None)
    return string + " "

def getHostSegmentText():
    username = os.getlogin()
    hostname = os.uname()[1]
    return username + "@" + hostname

def getDirectoryText():
    return os.getcwd().replace("/Users/rahulsalvi", "~", 1)

def main():
    segments = []

    if os.getenv('BACKGROUND') == 'light':
        hostFormat = Format('black', 'cyan', False, True)
        dirFormat = Format('black', 'cyan', False, False)
    else:
        hostFormat = Format('black', 'blue', False, True)
        dirFormat = Format('black', 'blue', False, False)

    hostText = getHostSegmentText()
    dirText = getDirectoryText()
    maxPromptSize = int(subprocess.check_output(['stty', 'size']).split()[1])/3
    if len(hostText+dirText) < maxPromptSize:
        segments.append(Segment(hostText, hostFormat))
    while (len(dirText) > maxPromptSize) and (dirText.count('/') > 1):
        dirs = dirText.split('/')
        dirText = "../" + '/'.join(dirs[2:])

    segments.append(Segment(dirText, dirFormat))

    sys.stdout.write(resolve(segments))

if __name__ == "__main__":
    main()
