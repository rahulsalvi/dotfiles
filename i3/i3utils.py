import json
import subprocess
from sortedcontainers import SortedList

def _subprocess2json(cmd):
    return json.loads(subprocess.run(cmd, capture_output=True).stdout)

def command(cmd):
    j = _subprocess2json(["i3-msg", cmd])
    return j[0]["success"]

def get_workspaces():
    return _subprocess2json(["i3-msg", "-t", "get_workspaces"])

def new_workspace_num():
    workspaces = get_workspaces()
    sorted_workspaces = SortedList(workspace["num"] for workspace in workspaces)
    for i,j in enumerate(sorted_workspaces, 1):
        if i != j:
            return i
    return len(sorted_workspaces)+1

def workspaces_for_current_output():
    workspaces = get_workspaces()
    focused_workspace = list(filter(lambda x: x["focused"], workspaces))[0]
    return focused_workspace, \
           list(filter(lambda x: x["output"] == focused_workspace["output"], \
                       workspaces))

def next_workspace_for_current_output_num():
    current_workspace, output_workspaces = workspaces_for_current_output()
    sorted_workspaces = SortedList(workspace["num"] for workspace in output_workspaces)
    current_num = sorted_workspaces.index(current_workspace["num"])
    return sorted_workspaces[(current_num + 1) % len(sorted_workspaces)]

def prev_workspace_for_current_output_num():
    current_workspace, output_workspaces = workspaces_for_current_output()
    sorted_workspaces = SortedList(workspace["num"] for workspace in output_workspaces)
    current_num = sorted_workspaces.index(current_workspace["num"])
    return sorted_workspaces[(current_num - 1) % len(sorted_workspaces)]
