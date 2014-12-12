#!/bin/bash

#this script emulates a s/key system with a client side persistant file named:
#  "clientpass"
#and a serverside persistant file named:
#  "serverpass"
#  "clientpass" contains a key piece of information namely:
#  n -- the number of times to has the password before checking against against
#       the server side
pass=$1

read -r n < clientpass
nminusone=$((n - 1))

for i in `seq 1 $nminusone`
do
    pass=`echo -n $pass | shasum -a 256`
done

#pass now contains the password hashed n times

pass1=`echo -n $pass | shasum -a 256`

read -r serverline < serverpass

echo $serverline > temp1
echo $pass1 > temp2
diff temp1 temp2 > /dev/null

if [[ $? == 0 ]];
then
    echo success!!! password matches
    echo $pass > serverpass
    echo $nminusone > clientpass
else
    echo "failure!!! password does not match"
fi

rm temp1 temp2

