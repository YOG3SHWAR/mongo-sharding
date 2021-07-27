#!/bin/bash

echo "Config servers"
docker-compose -f config-server/docker-compose.yaml up -d


echo "Shard 1 servers"
docker-compose -f shard1/docker-compose.yaml up -d


echo "Shard 2 servers"
docker-compose -f shard2/docker-compose.yaml up -d


echo "Shard 3 servers"
docker-compose -f shard3/docker-compose.yaml up -d


echo "Mongos Router"
docker-compose -f mongos/docker-compose.yaml up -d

echo "All done!"