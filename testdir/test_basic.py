#!/usr/bin/env python3
'''
to use, install curatorbin and then run this script.
It should return a valid curator path, and then error.
This is in a separate dir, 
because if it were in the top-level dir it would use the local curatorbin.
'''

import os
import curatorbin
import pytest
import subprocess
import importlib.resources

VERSION_STRING = 'curator version a91ffb61aeae8e934d50f351155c88a75e1cb614'

def test_path():
    curatorpath = curatorbin.get_curator_path()
    path_version = subprocess.check_output([curatorpath, '--version']).decode().strip()
    assert path_version == VERSION_STRING

def test_run():
    run_version = curatorbin.run_curator('--version').decode().strip()
    assert run_version == VERSION_STRING

test_path()
test_run()
