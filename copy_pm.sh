#!/bin/bash

array=( "00_ShellExecute.pm")

user=deos
ip=192.168.123.59
#ip=172.20.47.200
id="~/.ssh/test_rsa"

ssh $user@$ip -i $id "sudo bash -c 'mkdir /tmp/fhem; chown -R deos:deos /tmp/fhem'"

for file in "${array[@]}"
do
    scp  -i $id FHEM/$file $user@$ip:/tmp/fhem/
    ssh $user@$ip -i $id "sudo bash -c 'mv -f /tmp/fhem/$file /docker/runtime/fhem/FHEM/$file;chown 6061:6061 /docker/runtime/fhem/FHEM/$file'"
    ssh $user@$ip -i $id "sudo bash -c 'cd /docker/runtime/fhem; perl fhem.pl 7072 \"reload $file\"'"
done

ssh $user@$ip -i $id "sudo bash -c 'rm -Rf /tmp/fhem; cd /docker/runtime/fhem; perl fhem.pl 7072 rereadcfg'"
