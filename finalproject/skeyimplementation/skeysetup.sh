#!/bin/bash

#takes in a password and a value for n
# $1=password
# $2=n
n=$2
nminusone=$((n - 1))
pass=$1
for i in `seq 1 $nminusone`
do
    pass=`echo -n $pass | shasum -a 256`
done

echo $nminusone > clientpass
echo $pass      > serverpass
