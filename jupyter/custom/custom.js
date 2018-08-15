Jupyter.keyboard_manager.command_shortcuts.add_shortcut('e', {
    handler : function (event) {
        function callback(msg) {
            cell.set_text(msg.content.text);
        }
        var cell = Jupyter.notebook.get_selected_cell();
        // Quote the cell text and *then* double any backslashes.
        var cell_text = JSON.stringify(cell.get_text()).replace(/\\/g, "\\\\");
        var cmd = `exec("""
cell_text = ${cell_text}
ext = "${cell.cell_type == 'code' ? 'py' : 'md'}"
sep = "#-#-# under edit in file "
prefix, _, fname = cell_text.partition(sep)

if not fname or prefix:
    # Create file and open editor, pass back placeholder.
    import itertools, os, subprocess

    for i in itertools.count():
        fname = 'cell_{}.{}'.format(i, ext)
        try:
            with open(fname, 'x') as f:
                f.write(cell_text)
        except FileExistsError:
            pass
        else:
            break

    # Run editor in the background.
    subprocess.Popen(['termite', '-e', 'nvim '+os.path.abspath(fname)],
                     stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

    print(sep, fname, sep='', end='')
else:
    # Cell has been in edit: read it in and pass it back, and delete it.
    import os

    try:
        with open(fname, 'r') as f:
            cell_text = f.read()
    except FileNotFoundError:
        print("# File {} could not be inserted back.".format(fname), end='')
    else:
        if cell_text.endswith('\\\\n'):
            cell_text = cell_text[:-1]
        print(cell_text, end='')
        os.remove(fname)
""", None, {})`;
        Jupyter.notebook.kernel.execute(cmd, {iopub: {output: callback}},
                                        {silent: false});
        return false;
    }}
);
