#!/bin/bash
set -xeou pipefail

# updateFromCurator.sh allows automated hash updating.
# It is intended to be used in the curatorbin root dir.
# VERSION_UPDATE will increment the major/minor/patch versions as specified, with MAJOR.MINOR.PATCH
## usage: ./updateFromCuratorCurator.sh ${VERSION_UPDATE}
## usage: ./updateFromCuratorCurator.sh 0.1.0

NEW_HASH=$(git ls-remote git://github.com/mongodb/curator.git | head -n 1 | awk '{print $1}')
old_hash=$(grep "VERSION_STRING =" testdir/test_basic.py | awk '{print $5}')
old_hash_stripped=${old_hash%\'}
./changeover.sh ${old_hash_stripped} ${NEW_HASH}

old_version=$(grep "version=" setup.py | awk -F '"' '{print $2}')

replacement=$(echo ${old_version}.${1} | awk -F "." '{print $1+$4"."$2+$5"."$3+$6}')

perl -p -i -e "s/${old_version}/${replacement}/g" setup.py
