---
layout: post
title: CTMixtures Simulation in Docker
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories:
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Overview ###

[Docker](https://www.docker.com/) is a lightweight virtualization mechanism which allows one to package ("containerize") an application to run almost anywhere.  Docker containers make excellent teaching tools, and potentially are excellent ways of making research code replicable or at least demonstrable.  

I put together a Docker container for my recent [CTMixtures](https://github.com/mmadsen/ctmixtures) simulation software, since the paper addressing equifinality and CT models is nearly complete.  I will be pointing to the Docker container as well as the original source repository in the paper itself, in case someone wants to simply check what the software does, instead of building upon the source itself.  These are some notes on putting together a Docker container for a simulation system. 

### Notes ###

1.  The dominant philosophy for Docker containers is "micro" installations -- each container runs a separate application, and the container runs almost nothing except a single process.  The default Ubuntu and other Linux base images follow this philosophy to the letter.  Booting a simple Bash process on the base Ubuntu image yields a system without even an "init" process.  This is the most stripped down Unix system I've ever seen.  

2.  With my own simulations, output is always written to a MongoDB database, for ease of analysis later (since there is no fixed schema, and I can store nested maps and arrays easily).  

3. By default, Docker would like the MongoDB server to be one container, and my simulation code another container, talking over the shared private network between containers.  

4. This is how it should work in production, but I think it makes things difficult for teaching or demonstration purposes.  In such contexts, students or the instructor has to launch two containers, link them on the network, etc.  That raises the bar for a simple teaching example, or it makes it difficult for someone to quickly "check someone's work" if containers are submitted as "homework answers," for example.

5.  Multiple process containers are definitely possible, however, if you choose the right base image.  I used the **phusion/baseimage:latest** image, which runs an incredibly lightweight version of init (believe it or not, it's a shell script) and the "runit" replacement for SysV system startup.  It starts up instantly, gives you syslog, runs daemons in the background, and still can function as a single-process container if desired.  I strongly recommend this as your base image.  

6.  There does seem to be issues with "boot2docker" on Mac OS X and networking between the container and host.  I just can't make it work.  Searching, I'm not sure if this is a new issue (perhaps a Yosemite conflict?) because apparently other folks make it work using the "boot2docker" process IP address and the port mapping, but I haven't gotten it working yet.  Which means it's hard to connect tools to the container for reading the MongoDB database, etc.  

### CTMixtures as Docker Container ###

The repository is located at [docker-ctmixtures](https://github.com/mmadsen/docker-ctmixtures).  Soon it'll also be on Docker Hub, but I need to explore how people distribute their work between Github and Docker Hub first, make sure there's one authoritative place for edits.  

