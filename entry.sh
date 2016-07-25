#!/usr/bin/env bash

set -e

[ "$DEBUG" == 'true' ] && set -x

# Config checks
[ -z "$MAILMAN_URLHOST" ] && echo "Error: MAILMAN_URLHOST not set" && exit 128 || true
[ -z "$MAILMAN_EMAILHOST" ] && echo "Error: MAILMAN_EMAILHOST not set" && exit 128 || true
[ -z "$MAILMAN_ADMINMAIL" ] && echo "Error: MAILMAN_ADMINMAIL not set" && exit 128 || true
[ -z "$MAILMAN_ADMINPASS" ] && echo "Error: MAILMAN_ADMINPASS not set" && exit 128 || true

# Copy default mailman etc from cache
if [ ! "$(ls -A /etc/mailman)" ]; then
   cp -a /etc/mailman.cache/. /etc/mailman/
fi

# Copy default mailman data from cache
if [ ! "$(ls -A /var/lib/mailman)" ]; then
   cp -a /var/lib/mailman.cache/. /var/lib/mailman/
fi

# Copy default spool from cache
if [ ! "$(ls -A /var/spool/postfix)" ]; then
   cp -a /var/spool/postfix.cache/. /var/spool/postfix/
fi

# Fix permissions
/usr/lib/mailman/bin/check_perms -f

# If master list does not exist, create it
if [ ! -d /var/lib/mailman/lists/mailman ]; then
    /var/lib/mailman/bin/newlist --quiet --urlhost=$MAILMAN_URLHOST --emailhost=$MAILMAN_EMAILHOST mailman $MAILMAN_ADMINMAIL $MAILMAN_ADMINPASS
fi

# Fix Postfix settings
postconf -e mydestination=${MAILMAN_EMAILHOST}
postconf -e myhostname=${HOSTNAME}

#postconf -e mailbox_size_limit=20971520
# Fixme, support TLS
#smtpd_tls_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
#smtpd_tls_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
#smtpd_use_tls=yes

# Init Postfix Config
/usr/lib/mailman/bin/genaliases -q >> /etc/aliases
newaliases

exec $@
