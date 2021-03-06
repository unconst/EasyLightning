
echo "Creating Digital Ocean Droplet.."
docker-machine create  --driver digitalocean  --digitalocean-image ubuntu-18-04-x64   --digitalocean-size "1gb" --digitalocean-access-token $DOTOKEN lnd


echo "Openning Firewalls on Droplet.."
docker-machine ssh lnd 'ufw allow 9735/tcp'
docker-machine ssh lnd 'ufw allow 8080/tcp'
docker-machine ssh lnd 'ufw allow 10009/tcp'
docker-machine ssh lnd 'ufw reload'
docker-machine ssh lnd 'ufw --force enable'

echo "Setting docker env to the remote machine..."
eval $(docker-machine env lnd)

echo "Composing Bitcoin and LND services on the droplet..."
docker-compose up -d

sleep 2

echo "Printing LND logs..."
docker logs --tail 100 lnd_container

echo "Printing Bitcoind logs..."
docker logs --tail 100 bitcoind_container

echo "Adddin scripts to your path..."
export PATH=$PATH:$(pwd)/scripts'


// 7. Create Lnd wallet.
dlncli create

// 8. Get lnd info.
dlncli getinfo
e.g.
{
    "identity_pubkey": "...",
    "alias": "...",
    "num_pending_channels": 0,
    "num_active_channels": 0,
    "num_peers": 0,
    "block_height": 183310,
    "block_hash": "000000000000044e7d9ad40ca02efd61254cbf300f46535ef18a4a5aad325518",
    "synced_to_chain": false,
    "testnet": false,
    "chains": [
        "bitcoin"
    ],
    "uris": [
    ],
    "best_header_timestamp": "1235562181",
    "version": "0.5.2-beta commit=v0.5.2-beta",
    "num_inactive_channels": 0
}


// 9. Get bitcoind info.
dbitcoin-cli --rpcuser=$RPCUSER --rpcpassword=$RPCPASS -getinfo
e.g.
{
  "version": 170100,
  "protocolversion": 70015,
  "walletversion": 169900,
  "balance": 0.00000000,
  "blocks": 183310,
  "timeoffset": 0,
  "connections": 8,
  "proxy": "",
  "difficulty": 1468195.427220831,
  "testnet": false,
  "keypoololdest": 1549652628,
  "keypoolsize": 1000,
  "paytxfee": 0.00000000,
  "relayfee": 0.00001000,
  "warnings": ""
}

// 10. Set docker env back to the local machine.
eval $(docker-machine env -u)



