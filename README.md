
# Requirements:
1. docker
1. docker-compose
1. docker-machine
1. digital ocean account & access token

# Steps:

```
// 1. Set your env vars.
export DOTOKEN=<your-digital-ocean-token>
export RPCUSER=<your-rpc-user>
export RPCPASS=<your-rpc-password>


// 2. Create a cheap Droplet on Digital Ocean.
docker-machine create  --driver digitalocean  --digitalocean-image ubuntu-18-04-x64   --digitalocean-size "1gb" --digitalocean-access-token $DOTOKEN lnd


// 3. Get this repo.
git clone https://github.com/unconst/DockerBitcoindLND
cd EasyLightning


// 4. Compose Bitcoin and LND on droplet.
eval $(docker-machine env lnd)
docker-compose up -d
docker logs --tail 100 lnd_container
docker logs --tail 100 bitcoind_container
eval $(docker-machine env -u)


// 5. Add scripts to your path.
export PATH=$PATH:$(pwd)/scripts


// 6. Create Lnd wallet.
dlncli create


// 7. Get lnd info.
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


// Get bitcoind info.
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

...
// Wait for bitcoin to sync ... could take 12 hours or so.
...


```





