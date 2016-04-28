import sys
import os
import subprocess
from enum import Enum

promptTime = os.getenv("PROMPTTIME", False)
if promptTime:
    import time

encoding = sys.getdefaultencoding()

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

def getGitInfo(isInDotGitFolder):
    cmd = subprocess.Popen(['git', 'symbolic-ref', '-q', 'HEAD'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    out, err = cmd.communicate()
    if 'fatal: Not' in err.decode(encoding):
        return "", -1
    elif not out:
        sha = subprocess.check_output(['git', 'rev-parse', '--short', 'HEAD'])
        return '\u27a6'+" "+sha.decode(encoding).rstrip(), 2
    else:
        if isInDotGitFolder:
            return ".git", 0
        changes = subprocess.check_output(['git', 'status', '--porcelain'])
        if not changes:
            return '\ue0a0'+" "+out.decode(encoding).replace("refs/heads/", "", 1).rstrip(), 0
        else:
            if "??" in changes.decode(encoding):
                return '\ue0a0'+" "+out.decode(encoding).replace("refs/heads/", "", 1).rstrip()+" \u00b1", 1
            else:
                return '\ue0a0'+" "+out.decode(encoding).replace("refs/heads/", "", 1).rstrip(), 1

def main():
    if promptTime:
        startTime = time.time()
    segments = []

    if os.getenv('BACKGROUND') == 'light':
        hostFormat = Format('black', 'cyan', False, True)
        dirFormat = Format('black', 'cyan', False, False)
        gitCleanFormat = Format('black', 'green', False, False)
        gitDirtyFormat = Format('black', 'yellow', False, False)
        gitDetachedFormat = Format('black', 'red', False, False)
    else:
        hostFormat = Format('black', 'blue', False, True)
        dirFormat = Format('black', 'blue', False, False)
        gitCleanFormat = Format('black', 'green', False, False)
        gitDirtyFormat = Format('black', 'yellow', False, False)
        gitDetachedFormat = Format('black', 'red', False, False)

    hostText = getHostSegmentText()
    dirText = getDirectoryText()
    gitText, gitStatus = getGitInfo(".git" in dirText)

    maxPromptPercent = os.getenv("MAXPROMPTSIZE", 33)
    maxPromptPercent = int(maxPromptPercent)/100
    maxPromptSize = int(subprocess.check_output(['stty', 'size']).split()[1]) * maxPromptPercent

    if len(hostText+dirText+gitText) < maxPromptSize:
        segments.append(Segment(hostText, hostFormat))

    while (len(dirText+gitText) > maxPromptSize) and (dirText.count('/') > 1):
        dirs = dirText.split('/')
        dirText = "../" + '/'.join(dirs[2:])
    segments.append(Segment(dirText, dirFormat))

    if gitStatus == 0:
        segments.append(Segment(gitText, gitCleanFormat))
    elif gitStatus == 1:
        segments.append(Segment(gitText, gitDirtyFormat))
    elif gitStatus == 2:
        segments.append(Segment(gitText, gitDetachedFormat))

    if promptTime:
        segments.append(Segment(str(time.time()-startTime), Format('black', 'white', False, False)))

    sys.stdout.write(resolve(segments))

if __name__ == "__main__":
    main()
