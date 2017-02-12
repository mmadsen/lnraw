---
layout: post
title: Amazon EC2 AMI for deep neural networks and classification problems
tags: [experiments, computing, aws, ML, deep learning, HPC, classification]
categories:
- project-coarse grained model
---


**UPDATE: 5-23-2016**:  I have updated the public AMI to upgrade various dependencies, and to add Open Grid Engine to facilitate parallel job execution on a multiple core or multiple instance cluster.  The NEW AMI is `ami-07f80f6a` with the name "Simulation-DNN-GridEngine Linux".  Thanks to Israel Malkin for pointing out that I hadn't made the new AMI public after creating it, that's now fixed.  


### AMI for Deep Neural Networks ###

Given the increasing quality of libraries for building deep neural network architectures, I've been exploring whether DNNs can improve my accuracy in distinguishing between the empirical signatures of cultural transmission models.  I started out with Lasagne driving Theano, since Theano itself is pretty nuts and bolts and I occasionally find getting the right tensor shapes a bit baffling.  I quickly found Keras, which is another (and very well designed) wrapper around **both** TensorFlow and Theano, which also allows one to switch between backends.  Keras is designed for quick prototyping and research, which is perfect for this context.  

Being able to switch backends also turns out to be fairly handy if you develop on OS X, because if you've got Yosemite and the current version of Xcode (7.1), the CLANG compiler toolchain is not compatible with Theano and the CUDA nvcc compiler.  Which meant that I'd been developing in an Ubuntu 15.10 virtual machine on my laptop, which was sufficient for testing, and then pushing code to a box with an NVIDIA GPU.  By switching the Keras backend to TensorFlow, I can test the main body of my model code on the Mac, and then switch it back to Theano to run on a box with a GPU (since Theano on GPU on Linux is generally thought to be better performing than TensorFlow in general right now).

I looked around a bit for AMIs to quickly spin up an EC2 instance, and mostly found a lot of broken links to AMIs that weren't available in my default `us-east-1` availability zone.  So, I spent a couple of hours today building one with everything I needed.  

The public AMI `ami-5cc6e636` is based upon Ubuntu 14.04, with the following added:

* Caffe direct from Github bleeding edge
* cuDNN v3.0 from NVIDIA
* CUDA 7.0, with driver built for the Linux 3.13 kernel that Ubuntu 14.04 uses
* Anaconda Python 2.7
* Theano from bleeding edge, which means 0.8 at this point in time
* Lasagne from bleeding edge, which means 0.2 at this point
* Keras, from `pip install`
* nolearn, from `pip install`
* Seaborn for visualization, from `pip install`
* Graphviz

The image has a mounted EBS volume for data, and a 32GB root partition since there's a lot of stuff installed here.

Fire this AMI up on an `g2.2xlarge` instance type for 8 CPU cores, 15GB of RAM, and a GPU with 1,536 CUDA cores.  I will try to keep an AMI with these specs up to date, and since the AMI ID will change, check [the tag `AWS`](http://notebook.madsenlab.org/tag/aws.html) for updates.

