#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

# Config checks
[ -z "$MAILMAN_URLHOST" ] && echo "Error: MAILMAN_URLHOST not set" && exit 128 || true
[ -z "$MAILMAN_EMAILHOST" ] && echo "Error: MAILMAN_EMAILHOST not set" && exit 128 || true
[ -z "$MAILMAN_ADMINMAIL" ] && echo "Error: MAILMAN_ADMINMAIL not set" && exit 128 || true
[ -z "$MAILMAN_ADMINPASS" ] && echo "Error: MAILMAN_ADMINPASS not set" && exit 128 || true

# function generate_aliases() {
# LISTNAME=$1
# cat << EOF >> /etc/aliases
# ## ${LISTNAME} mailing list
# ${LISTNAME}:              "|/var/lib/mailman/mail/mailman post ${LISTNAME}"
# ${LISTNAME}-admin:        "|/var/lib/mailman/mail/mailman admin ${LISTNAME}"
# ${LISTNAME}-bounces:      "|/var/lib/mailman/mail/mailman bounces ${LISTNAME}"
# ${LISTNAME}-confirm:      "|/var/lib/mailman/mail/mailman confirm ${LISTNAME}"
# ${LISTNAME}-join:         "|/var/lib/mailman/mail/mailman join ${LISTNAME}"
# ${LISTNAME}-leave:        "|/var/lib/mailman/mail/mailman leave ${LISTNAME}"
# ${LISTNAME}-owner:        "|/var/lib/mailman/mail/mailman owner ${LISTNAME}"
# ${LISTNAME}-request:      "|/var/lib/mailman/mail/mailman request ${LISTNAME}"
# ${LISTNAME}-subscribe:    "|/var/lib/mailman/mail/mailman subscribe ${LISTNAME}"
# ${LISTNAME}-unsubscribe:  "|/var/lib/mailman/mail/mailman unsubscribe ${LISTNAME}"
# EOF
# }

# # Generate all aliases for postfix
# for LISTDIR in /var/lib/mailman/lists/*; do
#     LIST=$(basename $LISTDIR)
#     generate_aliases $LIST
# done


# Copy default spool from cache
if [ ! "$(ls -A /var/spool/postfix)" ]; then
   cp -a /var/spool/postfix.cache/. /var/spool/postfix/
fi

if [ ! "$(ls -A /var/spool/postfix)" ]; then
   cp -a /var/lib/mailman.cache/. /var/lib/mailman/
fi

# If master list does not exist, create it
if [ ! -d /var/lib/mailman/lists/mailman ]; then
    /var/lib/mailman/bin/newlist --quiet --urlhost=$MAILMAN_URLHOST --emailhost=$MAILMAN_EMAILHOST mailman $MAILMAN_ADMINMAIL $MAILMAN_ADMINPASS
fi

# Init Config
/usr/lib/mailman/bin/genaliases -q >> /etc/aliases
newaliases

exec $@
