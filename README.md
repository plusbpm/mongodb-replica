
This repository contains Dockerfile for [MongoDB 4.2](https://www.mongodb.org)
container, based on the [Alpine edge](https://hub.docker.com/_/alpine/) image.


## Usage

To run `mongod`:

	$ docker run -d --name mongo -p 27017:27017 plsbpm/mongodb-replica

You can also specify the database repository where to store the data
with the volume -v option:

    $ docker run -d --name mongo -p 27017:27017 \
	  -v /somewhere/onmyhost/mydatabase:/data/db \
	  mvertes/alpine-mongo

To run a shell session:

    $ docker exec -ti mongo sh

To use the mongo shell client:

	$ docker exec -ti mongo mongo

The mongo shell client can also be run its own container: 

	$ docker run -ti --rm --name mongoshell mongo host:port/db

## Limitations

- On MacOSX, volumes located in a virtualbox shared folder are not
  supported, due to a limitation of virtualbox (default docker-machine
  driver) not supporting fsync().
