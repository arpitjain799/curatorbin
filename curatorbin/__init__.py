import os
import subprocess
import sys

def run_curator():
    #current_module = sys.modules[__name__]
    current_module = __import__(__name__)
    build_path = current_module.__path__[0]
    print()
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(build_path)
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print()

    if sys.platform == "darwin":
        os_platform = "macos"
    elif sys.platform == "win32":
        os_platform = "windows-64"
    elif sys.platform.startswith("linux"):
        os_platform = "ubuntu1604"
    else:
        raise OSError("Unrecognized platform. "
                      "This program is meant to be run on MacOS, Windows, or Linux.")

    curator_path = os.path.join(build_path, "curator")
    if sys.platform == "win32":
        curator_path += ".exe"
    git_hash = "d11f83290729dc42138af106fe01bc0714c24a8b"
    curator_exists = os.path.isfile(curator_path)
    curator_same_version = False
    if curator_exists:
        curator_version = subprocess.check_output([curator_path,
                                                   "--version"]).decode('utf-8').split()
        curator_same_version = git_hash in curator_version

        if curator_same_version : 
            # execute curator, passing along arguments
            subprocess.check_call([curator_path] + sys.argv)

        else:
            raise OSError(
                "Found a different version of curator. Looking for '%s', but found '%s'."
                "Something has gone terribly wrong in the python wrapper for curator", git_hash, curator_version)
    else:
        raise OSError("Something has gone terribly wrong. curator binary not found at %s", curator_path)

