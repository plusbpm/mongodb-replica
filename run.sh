#!/bin/sh
# set -e

DB_NAME=runningDB

waitForMongoNetwork() {
  echo "WAITING MONGO NETWORK"
  while ! nc -w 1 127.0.0.1 27017 2>/dev/null
  do
    sleep 1
  done
}

waitForMongoWritable() {
  echo "WAITING MONGO WRITEABLE"
  while ! mongo $DB_NAME --eval 'db.readyTest.insertOne({ts: new Date()})' > /dev/null
  do
    sleep 1
  done
}


echo "BEGIN WORK"

[ "$(stat -c %U /data/db)" = mongodb ] || chown -R mongodb /data/db

echo "RUNNING MONGO IN BACKGROUND"

mongod --replSet rs0 $@ &

waitForMongoNetwork

echo "INITIATE REPLICA"
mongo $DB_NAME --eval 'rs.initiate({ _id: "rs0", members: [{ _id: 0, host: "127.0.0.1:27017" }] })'

waitForMongoNetwork
waitForMongoWritable

echo "DROP TEMPORARILY DB"
mongo $DB_NAME --eval 'db.dropDatabase()'

echo "WAIT MONGOD FOREVER"
wait