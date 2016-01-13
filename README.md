# Supported tags and respective `Dockerfile` links #

+ [`1.1.2`, `latest`, (1.1.2/Dockerfile)](https://github.com/mathieul/docker-phoenix/blob/1.1.2/Dockerfile)
+ [`1.1.1` (1.1.1/Dockerfile)](https://github.com/mathieul/docker-phoenix/blob/1.1.1/Dockerfile)
+ [`1.1.0` (1.1.0/Dockerfile)](https://github.com/mathieul/docker-phoenix/blob/1.1.0/Dockerfile)

This image contains everything you need for a working development environment for Phoenix applications using the Postgresql database (without the database server, just the database client to allow for running Ecto mix tasks).

phoenix 1.1.2 + elixir 1.2.0 + erlang 18.1 + postgres client 9.4 + node 5.3.0

![Phoenix Logo](https://www.filepicker.io/api/file/9prSmznZTiaRRmI3t89E)

# How to use this image #

This image expects the source of your phoenix application to be in `/code`.

To create a new application `MyApp`, create a new folder on the local machine and `cd` to it.

```docker
docker run -it --rm -v "$PWD:/code -w /phoenix mathieul/phoenix:latest mix phoenix.new /code --module MyApp --app MyApp"
```


# Acknowledgements #

This image was inspired by Marcelo Gonçalves' [marcelocg/phoenix](https://hub.docker.com/r/marcelocg/phoenix/) image.
