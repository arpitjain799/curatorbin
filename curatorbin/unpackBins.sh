#!/bin/bash
## unpackBins.sh is to be run in the curatorbin directory, under which 
# subdirectories e.g. macos, ubundu1604, exist. It downloads curator binaries,
# unpacks them, and updates the log.
set -xeo

gitHash=$1

function downloadTar {
	# download tarfile of curator, given a platform as first arg
	local os=$1
	local tarFile="curator-dist-${os}-${gitHash}.tar.gz"
	local s3URL="https://s3.amazonaws.com/boxes.10gen.com/build/curator/${tarFile}"
	pushd $os
		wget $s3URL
		tar -xf "${tarFile}"
		rm "${tarFile}"
		echo "${s3URL}" > placeholder.txt
	popd
}

downloadTar macos
downloadTar ubuntu1604
downloadTar windows-64
