## Docker sharded mongodb setup

### Config servers
Start config servers (3 member replica set)
```
docker-compose -f config-server/docker-compose.yaml up -d
```
Initiate replica set
```
mongo mongodb://192.168.0.105:40001
```
```
rs.initiate(
  {
    _id: "cfgrs",
    configsvr: true,
    members: [
      { _id : 0, host : "192.168.0.105:40001" },
      { _id : 1, host : "192.168.0.105:40002" },
      { _id : 2, host : "192.168.0.105:40003" }
    ]
  }
)

rs.status()
```

### Shard 1 servers
Start shard 1 servers (3 member replicas set)
```
docker-compose -f shard1/docker-compose.yaml up -d
```
Initiate replica set
```
mongo mongodb://192.168.0.105:50001
```
```
rs.initiate(
  {
    _id: "shard1rs",
    members: [
      { _id : 0, host : "192.168.0.105:50001" },
      { _id : 1, host : "192.168.0.105:50002" },
      { _id : 2, host : "192.168.0.105:50003" }
    ]
  }
)

rs.status()
```

### Mongos Router
Start mongos query router
```
docker-compose -f mongos/docker-compose.yaml up -d
```

### Add shard to the cluster
Connect to mongos
```
mongo mongodb://192.168.0.105:60000
```
Add shard
```
mongos> sh.addShard("shard1rs/192.168.0.105:50001,192.168.0.105:50002,192.168.0.105:50003")
mongos> sh.status()
```
## Adding another shard
### Shard 2 servers
Start shard 2 servers (3 member replicas set)
```
docker-compose -f shard2/docker-compose.yaml up -d
```
Initiate replica set
```
mongo mongodb://192.168.0.105:50004
```
```
rs.initiate(
  {
    _id: "shard2rs",
    members: [
      { _id : 0, host : "192.168.0.105:50004" },
      { _id : 1, host : "192.168.0.105:50005" },
      { _id : 2, host : "192.168.0.105:50006" }
    ]
  }
)

rs.status()
```
### Add shard to the cluster
Connect to mongos
```
mongo mongodb://192.168.0.105:60000
```
Add shard
```
mongos> sh.addShard("shard2rs/192.168.0.105:50004,192.168.0.105:50005,192.168.0.105:50006")
mongos> sh.status()
```
## Adding another shard
### Shard 3 servers
Start shard 3 servers (3 member replicas set)
```
docker-compose -f shard3/docker-compose.yaml up -d
```
Initiate replica set
```
mongo mongodb://192.168.0.105:50007
```
```
rs.initiate(
  {
    _id: "shard3rs",
    members: [
      { _id : 0, host : "192.168.0.105:50007" },
      { _id : 1, host : "192.168.0.105:50008" },
      { _id : 2, host : "192.168.0.105:50009" }
    ]
  }
)

rs.status()
```
### Add shard to the cluster
Connect to mongos
```
mongo mongodb://192.168.0.105:60000
```
Add shard
```
mongos> sh.addShard("shard3rs/192.168.0.105:50007,192.168.0.105:50008,192.168.0.105:50009")
mongos> sh.status()
```