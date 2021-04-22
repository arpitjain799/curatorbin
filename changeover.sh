#!/bin/bash
set -xeou pipefail

# changeover.sh contains a utility for easily switching over the git hash, 
# and is intended to be used in the curatorbin root dir 
## usage: ./changeover.sh ${OLD_HASH} ${NEW_HASH}
## usage: ./changeover.sh 4e006115921edd2d3ac5cac8d2d78d7a9ed908d2 a251eabef5ed6ae71de5626de9a9a0ef8fda0968 

function replace_keyword {
        keyword=$1
        replacement=$2
        perl -p -i -e "s/${keyword}/${replacement}/g" testdir/test_basic.py curatorbin/__init__.py evergreen.yml
}

replace_keyword $1 $2
