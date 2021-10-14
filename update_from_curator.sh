#!/bin/bash
set -xeou pipefail

# update_from_curator.sh allows automated hash updating.
# It is intended to be used in the curatorbin root dir.
# VERSION_UPDATE will increment the major, minor, or patch versions as specified.
# Allowed strings are "major", "minor" or "patch", with any case.
## usage: ./update_from_curator.sh ${VERSION_UPDATE}
## usage: ./update_from_curator.sh MAJOR

# replace (with the latest curator hash) the hash in `testdir/test_basic.py`, `curatorbin/__init__.py` and `evergreen.yml`.
new_hash=$(git ls-remote git://github.com/mongodb/curator.git | head -n 1 | awk '{print $1}')
old_hash=$(grep "VERSION_STRING =" testdir/test_basic.py | awk '{print $5}')
old_hash_stripped=${old_hash%\'}
./changeover.sh ${old_hash_stripped} ${new_hash}

#This will be used to increment the version in the `setup.py` and `evergreen.yml` files.
old_version=$(grep "version=" setup.py | awk -F '"' '{print $2}')

sem_ver=$(echo "${1}" | awk '{print tolower($0)}')
if [ "${sem_ver}" == "major" ]
then
	replacement=$(echo ${old_version} | awk -F "." '{print $1+1".0.0"}')
elif [ "${sem_ver}" == "minor" ]
then
	replacement=$(echo ${old_version} | awk -F "." '{print $1"."$2+1".0"}')
elif [ "${sem_ver}" == "patch" ]
then
	replacement=$(echo ${old_version} | awk -F "." '{print $1"."$2"."$3+1}')

else
	echo "'${1}' is not major, minor, or patch"
	exit
fi

perl -p -i -e "s/${old_version}/${replacement}/g" setup.py evergreen.yml
