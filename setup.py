#!/usr/bin/env python3

from setuptools import setup
from setuptools.command.develop import develop
from setuptools.command.install import install
 
setup(
    name="piphack-curator",
    version="0.7",
    description="hack to install curator through pip",
    license="SSPLv1",
    classifiers=[
        "Environment :: Console",
        "Operating System :: MacOS :: MacOS X",
        "Operating System :: Microsoft :: Windows",
        "Operating System :: POSIX :: Linux",
        "Programming Language :: Python",
        "Programming Language :: Python :: 3.9",
    ],
    packages=["curatorbin"],
    package_data={"curatorbin": ["macos/curator","ubuntu-1604/curator","windows-64/curator.exe"]}
)

