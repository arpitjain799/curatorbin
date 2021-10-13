#!/bin/bash
set -xeou pipefail

# newCurator.sh allows automated version updating and hash updating.
# It is intended to be used in the curatorbin root dir.
# VERSION_UPDATE will increment the major/minor/patch versions as specified
## usage: ./newCurator.sh ${NEW_HASH} ${VERSION_UPDATE}
## usage: ./newCurator.sh a251eabef5ed6ae71de5626de9a9a0ef8fda0968 0.1.0


NEW_HASH=${1}
old_hash=$(grep "VERSION_STRING =" testdir/test_basic.py | awk '{print $5}')
old_hash_stripped=${old_hash%\'}
./changeover.sh ${old_hash_stripped} ${NEW_HASH}

old_version=$(grep "version=" setup.py | awk -F '"' '{print $2}')

replacement=$(echo ${old_version}.${2} | awk -F "." '{print $1+$4"."$2+$5"."$3+$6}')

perl -p -i -e "s/${old_version}/${replacement}/g"
