# go-gb-web-starter

A simple starter application using Golang, Nix, and riotjs.

## notes

 * src/nix/gb and src/nix/riot are custom packages, not in NixOS (as of commit f56ab9e5e4a31ead55efd9e1d9b55ddf70533908)
 * src/nix/gosu and src/nix/runc are backports from master or open pull requests to 16.03)
 * everything is gb based

Most of the docker support came from this post:

https://lethalman.blogspot.com/2016/04/cheap-docker-images-with-nix\_15.html

## commands

Once you are in the nix environment, you have access to a few commands:

 * buildDockerImages - builds every docker image into the system
 * loadDockerImages - loads already built docker images into docker via `docker load`
 * gb - will build everything go-related
 * make - will run gb and run the javascript minification commands



## TODO

 * buildGbBinary needs to support 'hooks'. Right now hooks are passed in via args.
 * docker-compose is included but not used.
 * most of docker.nix can be generalized.

