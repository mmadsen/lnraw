---
layout: post
title: CTMixtures Cluster Setup and Computing Environment
tags: [cultural transmission, time averaging, coarse graining, simulation, dissertation, open science, reproducible science, experiments, experiment-ctmixture]
categories: 
- project:coarse grained model
- model:ctmixtures
- experiment:experiment-ctmixtures
---

### Overview ###

In a previous experiment (`axelrod-ct`), I managed the EC2 simulation environment manually, with shell scripts to start simulations and to check on the status of runs.  It worked, but it's a pain in the butt, and it's hard to do replicably.  [StarCluster](http://star.mit.edu/cluster/index.html) is a better solution, but I didn't take the time before SAA2014 to become versed in its use.  

I am doing so for `ctmixtures` and `seriationct`, and thus far I'm impressed.  Amazed, actually.  Starcluster abstracts away the process of directly dealing with EC2 instances, and instead creates a single logical cluster of nodes that you can drive from a "master" node using simple commands.  Some skill at using a Unix environment is pretty essential, although for very simple jobs with an executable and simple output, it might not be necessary.  

This note records the steps I took to get my computing cluster configuration working, and small tweaks I've made to the main simulation code and "run builder" scripts to ensure that everything works when you push it to the cluster environment.  I spent some time using a 1 node default configuration to understand job processing, the layout and basic commands, and I recommend you do the same.  It cost about five bucks of EC2 runtime to get to the point where I could run a test experiment on a true parallel cluster, and was money well spent.

Throughout, I'll try to highlight things to watch out for or issues/bugs I found, in **bold** type.  

### Installation ###

First, install StarCluster.  A slightly outdated version came with Anaconda python, so it's worth updating.  I had to install it from source to prevent some version conflicts, but you may be able to do:

```{.shell}
$ pip install --upgrade starcluster
```

If you encounter any errors whatsoever, download the source from MIT and just install it like any normal Python package.  

### Image Configuration ###

The first task is to configure an AMI or machine image for your cluster nodes.  StarCluster provides a number of AMIs which are preconfigured with all of the StarCluster runtimes, Sun Open Grid Engine, and other components which StarCluster relies upon.  It is strongly recommended that you start with one of these AMIs.  

**In fact, of the currently supported StarCluster AMI's, you should start with the Ubuntu 12.04 64 bit image, because EC2 has disabled APT repositories for ubuntu versions which are end-of-life.  You will not be able to install most software on the 13.04 or recent AMI's.  StarCluster is aware of this and planning another AMI set based on the next Ubuntu LTS release.  By the time you read this, there may be a 14.04 AMI to use**

1. Follow the StarCluster user's manual and edit `~/.starcluster/config` to contain paths to apporpriate EC2 RSA and SSH keys.  You can use an IAM account for this, which is now recommended rather than your base AWS administration account.  You don't need to edit much else here at the moment.  
1. Set up a single cluster host, which we'll then configure and turn into a custom AMI for all nodes in our cluster.  You can use a small instance type here because we're not processing, just installing and configuring.  

```{.shell}
$ starcluster start -o -s 1 -I m1.small -m ami-765b3e1f imagehost
```

After a couple of minutes, you can ssh into the master (and only) node for cluster `imagehost`:

```{.shell}
$ starcluster sshmaster imagehost
``` 

At this point, you can use `apt-get` to install software, after running `apt-get update` to refresh the software database, which will be stale given the frozen version in the AMI image.  For `ctmixtures`, I installed:

3.  `mongodb` -- which installs both the server and command line client
4.  `build-essential` -- already installed, but I checked for updates
5.  `git` -- already installed, but checked for updates

6. For Python, I prefer geneally to leave the system Python alone, and use `Anaconda Scientific Python`:

```{.shell}
$ curl -o anaconda2-installer.sh http://09c8d0b2229f813c1b93-c95ac804525aac4b6dba79b00b39d1d3.r79.cf1.rackcdn.com/Anaconda-2.0.1-Linux-x86_64.sh
$ bash anaconda2-installer.sh
```

7. Follow the prompts in the text-based installer, accepting the license agreement, and then put Anaconda somewhere accessible, like `/usr/local/anaconda`.  I also allowed the installer to prepend the Anaconda `bin` directory to root's path.  **I also should ensure that this is prepended to user `sgeadmin`'s  path since you execute jobs as this user**
8. I then created an EBS volume of sufficient size (200GB) to hold the MongoDB database on each simulation node, since they can grow quite large during a long simulation run.  I did this in the AWS web console, and attached it to `/dev/xvdf` (the default choice) to my running `imagehost-master` instance.  
9. Back on the command line in the `imagehost-master` itself, I then formatted the new volume, created a mount point, added it to `/etc/fstab` and mounted it before creating two working directories:

```{.shell}
$ /sbin/mkfs.ext4 /dev/xvdf
$ mkdir /sim
$ ...edited /etc/fstab...
$ mount -a
$ mkdir /sim/src
$ mkdir /sim/data
```

10.  I then stopped MongoDB, and edited `/etc/mongodb.conf` to put its `datadir` in `simdata` before restarting, and verifying that I could connect to the database via the command line client.  
11.  At this point, inside `/sim/src`, I cloned the `ctmixtures` repository at Version 2.1 of the release software, and verified that I could run the various scripts and a simulation on the command line, and that data was inserted into the database at the conclusion of the simulation.  This involved installing necessary python dependencies and compiling my module `slatkin-exact-tools`, which are taken care of by the following:

```{.shell}
$ apt-get install swig
$ pip install -r requirements.txt
$ sh install-slatkin-tools.sh
```

12. At this point, the system is capable of running my simulations and gives correct output to a test simulation:

```{.shell}
$ sim-ctmixture-timeaveraging.py --experiment test --debug 1 --configuration conf/allneutral-wellmixed.json --maxinittraits 10 --numloci 4 --conformismstrength 0.3 --anticonformismstrength 0.3 --innovationrate 0.25 --periodic 0 --kandlerinterval 100 --simulationendtime 1000000 --popsize 100 --seed 4207479710594528312
```
12. Time to turn this into an AMI which is ready to be cloned and run by StarCluster.  Exiting the SSH session, back on my local machine, I did the following:

13.  In the AWS web console, I determined the instance ID of the running `imagehost-master` instance.  Use the `ebsimage` command to turn this into an EBS AMI, which will freeze a snapshot both of the root and large database partition (your exact instance ID will vary, of course): 

```{.shell}
$ starcluster ebsimage i-42b409a9 ctmixtures-cluster
```

14. After a couple of minutes, a new AMI named `ctmixtures-cluster` appeared in my AMI list as a private AMI.  I then changed its permissions to be public, so anyone can use it to replicate one of my `ctmixtures` simulations without going through the steps above.  The AMI is identified as `ami-f668c49e`.  

### Cluster Configuration and Operations ###

The simplest thing for configuration is to edit `~/.starcluster/config` and give `ami-f668c49e` as the default AMI to use for the default cluster definition.  This will allow you to use StarCluster commands without additional arguments, and it will just use your default EC2 keys and this AMI unless otherwise specified.  I left the default number of nodes at 4, which is useful for testing, and can be overridden for production work on the command line.

You can start a cluster as follows, assuming the default cluster definition.  Choose a name for the cluster (e.g., `clustertest`):

```{.shell}
$ starcluster start clustertest
```

By default, this starts 4 instances using the `ctmixtures-cluster` AMI, and after a fair bit of automatic configuration, reports that all are ready and SSH is available.  You can then use `starcluster sshmaster clustertest` to log into the master and start jobs, etc.  

Stopping the cluster shuts down the instances, but leaves them in the instance list with volumes attached, and they can be restarted if desired.  This is useful for stopping the drain on your wallet while you do some analysis and then restart some work. 

Terminating the cluster removes the instances from your instance list, but in the current configuration it **DOES NOT remove the 200 GB EBS volumes you created**.  Do this manually after you terminate the instances if you do not want to be charged for the EBS storage.  I'm sure there's an instance and volume setting to have the volumes auto-delete, but I haven't set that up yet.  

When you have NO running instances, you should have no volumes associated with this cluster and image, but there should be a 10GB and 200GB snapshot which form part of the AMI itself.  These will be stored long-term but the cost is minimal.  


**FOR PART 2, SEE [CTMixtures Experiment Configuration and Execution](/project:coarse%20grained%20model/model:ctmixtures/experiment:experiment-ctmixtures/2014/09/14/ctmixtures-job-execution.html)**



