# pylint: disable=R1702,R0911

import logging
import os
import ycm_core

default_flags = [
        "-Wall",
        "-Wextra",
        "-Werror",
        "-Wno-c++98-compat",
        "-Wno-long-long",
        "-Wno-variadic-macros",
        "-fexceptions",
        "-ferror-limit=10000",
        "-DNDEBUG",
        "-std=c++11",
        "-xc++",
        "-I/usr/lib/",
        "-I/usr/include/"
        ]

source_exts = [
        ".cpp",
        ".cxx",
        ".c"
        ]

source_dirs = [
        "src",
        "test"
        ]

header_exts = [
        ".h",
        ".hxx",
        ".hpp"
        ]

header_dirs = [
        "include"
        ]

def make_relative_paths_in_flags_absolute(flags, working_directory):
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    path_flags = [ "-isystem", "-I", "-iquote", "--sysroot=" ]
    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith( "/" ):
                new_flag = os.path.join(working_directory, flag)

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith(path_flag):
                path = flag[len(path_flag):]
                new_flag = path_flag + os.path.join(working_directory, path)
                break

        if new_flag:
            new_flags.append(new_flag)
    return new_flags

def is_header_file(filename):
    extension = os.path.splitext(filename)[1]
    return extension in header_exts

def find_nearest(filename, target):
    parent = os.path.dirname(filename)
    candidate = os.path.join(parent, target)
    if os.path.isfile(candidate) or os.path.isdir(candidate):
        return candidate
    if parent == os.path.expanduser("~"):
        return None
    return find_nearest(parent, target)

def get_compilation_db_flags_for_file(filename):
    database_path = find_nearest(filename, "build/compile_commands.json")
    if not database_path:
        database_path = find_nearest(filename, "compile_commands.json")
        if not database_path:
            return None
    logging.info("ycm_extra_conf: found compilation database for file %s at %s",
                 str(filename),
                 str(database_path))
    database = ycm_core.CompilationDatabase(os.path.dirname(database_path))
    if not database:
        return None

    if is_header_file(filename):
        basename = os.path.splitext(filename)[0]
        for extension in source_exts:
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                compilation_info = database.GetCompilationInfoForFile(replacement_file)
                if compilation_info.compiler_flags_:
                    return compilation_info
            for header_dir in header_dirs:
                for source_dir in source_dirs:
                    src_file = replacement_file.replace(header_dir, source_dir)
                    if os.path.exists(src_file):
                        compilation_info = database.GetCompilationInfoForFile(src_file)
                        if compilation_info.compiler_flags_:
                            return compilation_info
        return None

    compilation_info = database.GetCompilationInfoForFile(filename)
    if compilation_info.compiler_flags_:
        return compilation_info
    return None

def get_include_flags_for_file(filename):
    include_dir = find_nearest(filename, "include")
    if include_dir:
        logging.info("ycm_extra_conf: found include directory for file %s at %s",
                     str(filename),
                     str(include_dir))
        return ["-I"+include_dir]
    return None


def get_flags_for_file(filename):
    compilation_db_flags = get_compilation_db_flags_for_file(filename)
    if compilation_db_flags:
        logging.info("ycm_extra_conf: using database compilation flags for file %s", str(filename))
        return make_relative_paths_in_flags_absolute(
                compilation_db_flags.compiler_flags_,
                compilation_db_flags.compiler_working_dir_)
    flags = default_flags
    include_flags = get_include_flags_for_file(filename)
    if include_flags:
        logging.info("ycm_extra_conf: using include directory flags for file %s", str(filename))
        flags = flags + include_flags
    return flags

def Settings(**kwargs):
    if kwargs["language"] == "cfamily":
        return {
                "flags": get_flags_for_file(kwargs["filename"]),
                "do_cache": True
                }
    return None
