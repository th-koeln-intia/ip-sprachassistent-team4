---
title: Docker
permalink: /knowledge/docker
subtitle: Demo page with a menubar
layout: page
show_sidebar: false
menubar: navigation
---

# Docker

## What is a Container?
A container is a process, that has been isolated from the processes on the host machine.

## What is an?
An image is a filesystem of a docker container, that also has been isolated from the filessystem of the host machine.
There are all dependencies, config files, scripts and binaries from the running Application saved.

## Create a Docker Container:
### Necessary files: 
 - In the `package.json` are all dependencies listed, that the running application needs.
 - The file `Dockerfile` is the description for docker, how to build the docker container.

`docker build -t getting-started .` is the command to build a container from the current folder and name it "getting-started".
The argument `-t name` gives the container a name.

## Start a Container
To build a docker container you need the command `docker run <name>`. 
useful arguments:
- `-d` this starts the container in the background ("deatached" mode)
- `-p 3000:3000` maps the port 3000 of the Container to the port 3000 of the host system, to make it available from outside the container.

## List all docker container
`docker ps` lists all Containers. With several informations.

## Stop a docker Container
`docker stop <the-container-id>` stops a Container. You can get the ID of the Container with the `docker ps` command.

## Remove a docker Container
`docker rm <the-container-id>` removes the container withe the given ID, you need to stop the Container first. To stop it automatic, add the argument `-f`.