#!/usr/bin/env python3

import os
import requests
import subprocess
import sys
import tarfile

from setuptools import setup
from setuptools.command.develop import develop
from setuptools.command.install import install
 
def install_curator(os_platform=None):
    build_path = os.path.dirname(os.path.realpath(__file__))
    if os_platform:
        build_path = os.path.join(build_path, os_platform)
    print()
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print(build_path)
    print('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    print()
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
        print(curator_version)

    if curator_exists and not curator_same_version:
        os.remove(curator_path)
        print(
            "Found a different version of curator. Downloading version %s of curator to enable"
            "process management using jasper.", git_hash)

    if not curator_exists or not curator_same_version:
        if sys.platform == "darwin":
            os_platform = "macos"
        elif sys.platform == "win32":
            os_platform = "windows-64"
        elif sys.platform.startswith("linux"):
            os_platform = "ubuntu1604"
        else:
            raise OSError("Unrecognized platform. "
                          "This program is meant to be run on MacOS, Windows, or Linux.")
        url = ("https://s3.amazonaws.com/boxes.10gen.com/build/curator/"
               "curator-dist-%s-%s.tar.gz") % (os_platform, git_hash)
        response = requests.get(url, stream=True)
        with tarfile.open(mode="r|gz", fileobj=response.raw) as tf:
            tf.extractall(path=build_path)

class PostDevelopCommand(develop):
    def run(self):
        develop.run(self)


class PostInstallCommand(install):
    def run(self):
        install.run(self)

setup(
    name="piphack-curator",
    version="0.4",
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
    install_requires=['requests>1.24'],
    cmdclass={
        "develop": PostDevelopCommand,
        "install": PostInstallCommand,
    },
    packages=["curator-bin"],

    package_data={"curator-bin": ["macos/curator","ubuntu-1604/curator","windows-64/curator"]}
)

