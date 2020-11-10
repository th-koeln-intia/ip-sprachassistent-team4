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
A Container is a process, that has been isolated from the processes on the host machine.

## What is an image?
An image is a filesystem of a docker Container, that also has been isolated from the filessystem of the host machine.
There are all dependencies, config files, scripts and binaries from the running Application saved.

## Create a Docker Container:
### Necessary files: 
 - The file `package.json` lists all dependencies that the running application needs..
 - The file `Dockerfile` is the description for docker how to build the Docker Container.

`docker build -t getting-started .` is the command to build a Container from the current folder and name it "getting-started".
The argument `-t name` gives the Container a name.

## Start a Container
To build a Docker Container you need the command `docker run <name>`. 
useful arguments:
- `-d` this starts the Container in the background ("deatached" mode)
- `-p 3000:3000` maps the port 3000 of the Container to the port 3000 of the host system, to make it available from outside the Container.

## List all Docker Container
`docker ps` lists all Containers with several informations.

## Stop a Docker Container
`docker stop <the-container-id>` stops a Container. You can get the ID of the Container with the command `docker ps`.

## Remove a Docker Container
`docker rm <the-container-id>` removes the Container with the given ID. You need to stop the Container first. To stop it automatically, add the argument `-f`.