#!/usr/bin/env python3
'''
to use, install curatorbin and then run this script.
It should return a valid curator path, and then error.
This is in a separate dir, 
because if it were in the top-level dir it would use the local curatorbin.
'''

import os
import curatorbin
import subprocess
import importlib.resources

curatorpath = curatorbin.get_curator_path()

print(curatorpath)

# errors
curatorbin.run_curator('foo', 'bar')


