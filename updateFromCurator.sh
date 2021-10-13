#!/bin/bash
set -xeou pipefail

# updateFromCurator.sh allows automated hash updating.
# It is intended to be used in the curatorbin root dir.
# VERSION_UPDATE will increment the major/minor/patch versions as specified
## usage: ./updateFromCuratorCurator.sh ${VERSION_UPDATE}
## usage: ./updateFromCuratorCurator.sh MAJOR

NEW_HASH=$(git ls-remote git://github.com/mongodb/curator.git | head -n 1 | awk '{print $1}')
old_hash=$(grep "VERSION_STRING =" testdir/test_basic.py | awk '{print $5}')
old_hash_stripped=${old_hash%\'}
./changeover.sh ${old_hash_stripped} ${NEW_HASH}

old_version=$(grep "version=" setup.py | awk -F '"' '{print $2}')


semVer=$(echo "${1}" | awk '{print tolower($0)}')

if [ "${semVer}" == "major" ]
then
	replacement=$(echo ${old_version} | awk -F "." '{print $1+1".0.0"}')
elif [ "${semVer}" == "minor" ]
then
	replacement=$(echo ${old_version} | awk -F "." '{print $1"."$2+1".0"}')
elif [ "${semVer}" == "patch" ]
then
	replacement=$(echo ${old_version} | awk -F "." '{print $1"."$2"."$3+1}')

else
	echo "'${1}' is not major, minor, or patch"
	exit
fi

perl -p -i -e "s/${old_version}/${replacement}/g" setup.py
