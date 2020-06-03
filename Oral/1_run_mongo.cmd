start "MongoDB 27017" mongod --replSet rs0 --port 27017 --bind_ip_all --dbpath "C:\Program Files\MongoDB\Server\4.2\data"  --oplogSize 128
start "MongoDB 27018" mongod --replSet rs0 --port 27018 --bind_ip_all --dbpath "C:\Program Files\MongoDB\Server\4.2\replica1"  --oplogSize 128
start "MongoDB 27019" mongod --replSet rs0 --port 27019 --bind_ip_all --dbpath "C:\Program Files\MongoDB\Server\4.2\replica2"  --oplogSize 128
