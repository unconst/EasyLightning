#!/usr/bin/env bash

# Copy env vars to bitcoin.conf
rm -f /root/bitcoin.conf
touch /root/bitcoin.conf
env >> /root/bitcoin.conf

# Remove default env vars.
sed -i '/FILENAME/d' ./root/bitcoin.conf
sed -i '/DOWNLOAD_URL/d' ./root/bitcoin.conf
sed -i '/VERSION/d' ./root/bitcoin.conf
sed -i '/HOSTNAME/d' ./root/bitcoin.conf
sed -i '/PWD/d' ./root/bitcoin.conf
sed -i '/HOME/d' ./root/bitcoin.conf
sed -i '/TERM/d' ./root/bitcoin.conf
sed -i '/SHLVL/d' ./root/bitcoin.conf
sed -i '/PATH/d' ./root/bitcoin.conf
sed -i '/_=/d' ./root/bitcoin.conf

echo "Starting Bitcoind with /root/bitcoin.conf"
cat /root/bitcoin.conf

# Start Bitcoind.
exec bitcoind -conf=/root/bitcoin.conf
