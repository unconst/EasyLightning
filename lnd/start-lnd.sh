#!/usr/bin/env bash

# Copy env vars to lnd.conf.
rm -f /root/lnd.conf
touch /root/lnd.conf
env >> /root/lnd.conf

# Remove default env vars.
sed -i '/HOSTNAME/d' ./root/lnd.conf
sed -i '/PWD/d' ./root/lnd.conf
sed -i '/HOME/d' ./root/lnd.conf
sed -i '/TERM/d' ./root/lnd.conf
sed -i '/SHLVL/d' ./root/lnd.conf
sed -i '/PATH/d' ./root/lnd.conf
sed -i '/_=/d' ./root/lnd.conf

# Print bitcoin.conf.
echo "Starting LND with /root/lnd.conf"
cat /root/lnd.conf

# Start LND
exec lnd --configfile=/root/lnd.conf
