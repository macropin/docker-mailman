#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service postfix stop; }" SIGINT
trap "{ /usr/sbin/service postfix stop; }" SIGTERM
trap "{ /usr/sbin/service postfix reload; }" SIGHUP
trap "{ /usr/sbin/service postfix stop; }" EXIT

# Copy new hosts incase outdated
cp /etc/hosts /var/spool/postfix/etc/hosts

# Cleanup stale pids incase we don't exit cleanly
rm -f /var/spool/postfix/pid/*

# start postfix
/usr/sbin/service postfix start

sleep 10 # wait for startup

# watch for postfix exit
while kill -0 $(pidof master) 2>/dev/null; do
    sleep 1
done
