# Docker Meteor Base

This is a base container, intended to be used in building other [Docker](https://docker.com/) containers for [Meteor](https://www.meteor.com/) apps.

## Basic Usage

1. Create a `Dockerfile` in your Meteor app directory that is based on `robbinsd/meteor-base`:

    ```bash
    # Dockerfile Contents
    FROM        robbinsd/meteor-base
    MAINTAINER  Example Jones <jones@example.com>
    ```

2. Build the new containerized version of your app:

    ```bash
    $ docker build -t <name>/<appname> .
    ```

3. Start a [MongoDB](https://registry.hub.docker.com/_/mongo/) container (remember its name):

    ```bash
    $ docker run --name mongo1 -d mongo
    ```

4. Start your app container, linked to your MongoDB container

    ```bash
    $ docker run --link mongo1:mongo -P <name>/<appname>
    ```

5. Use `docker ps` to discover the port assigned to your app (`49158` below):

    ```bash
    $ docker ps
    CONTAINER ID  IMAGE                    ...  PORTS                     NAMES
    5e52eebf7e5c  <name>/<appname>:latest  ...  0.0.0.0:49158->3000/tcp   hungry_lalande
    50b96c3e278b  mongo:latest             ...  27017/tcp                 mongo1
    ```

6. Open your Meteor app in the browser at [http://localhost:\<port\>](http://localhost) for Linux, or [http://192.168.59.103:\<port\>](http://192.168.59.103) for [Boot2Docker](http://boot2docker.io/) users.

## Notes

### Environment Variables

Set with one `-e` flag per variable when running your container (e.g. `docker run -e VAR1=value1 -e VAR2=value2 ...`)

* `MONGO_URL` enables the use of an existing MongoDB Deployment. Skip step 3 above.
* `DB` selects the database used in the MongoDB container (`test` by default).
* `ROOT_URL` sets the Meteor ROOT_URL.
* `PORT` sets the port, but will require adding an [`EXPOSE`](http://docs.docker.com/reference/builder/#expose) to your `Dockerfile`, or running behind another proxy container.
