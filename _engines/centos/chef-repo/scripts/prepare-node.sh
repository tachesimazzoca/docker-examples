#!/bin/sh

cd `dirname ${0}`/..

# host
h="${1}"
# node
n="${2}"
# environment
e="${3}"
# run_list
r="${4}"

./knife zero bootstrap "${h}" -N "${n}"
./knife node environment set "${n}" "${e}"
./knife node run_list set "${n}" "${r}"
