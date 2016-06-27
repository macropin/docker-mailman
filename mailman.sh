#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service mailman stop; }" SIGINT
trap "{ /usr/sbin/service mailman stop; }" SIGTERM
trap "{ /usr/sbin/service mailman reload; }" SIGHUP
trap "{ /usr/sbin/service mailman stop; }" EXIT

# start mailman
/etc/init.d/mailman start

sleep 10 # wait for startup

# wait until mailman exits
while kill -0 "$(cat /var/run/mailman/mailman.pid)"; do
    sleep 1
done
