
# ktor-nginx  

A boilerplate project that can be easily deployed to AWS.  
  
## Infrastructure

AWS ECS backed by a t2.micro instance (the type of instance and the number of instances backing the ECS cluster is configurable).

The main ktor app is launched in an ECS task and nginx is launched as a sidecar in the same task. All requests go through nginx.

## Prerequisites 

 - AWS CLI
 - Docker / Docker Hub

## Instructions

 1. Login to docker from terminal - `docker login`
 2. Configure AWS CLI - `aws configure`
3. Fill in the variables in the Makefile:
```
DOCKER_ACC=
APP_NAME=
```
4. Browse the repo and change folder/file/variable names to your liking. Currently these things are named "example".
5. Start developing & deploying (See below)

## Makefile

**make start**
Creates a local deployment on docker. App is available at `localhost:80` ie. `localhost`.

**make stop**
Stops the local deployment on docker.

**make deploy**
Deploys app to AWS. You must log in to AWS and get the IP of the EC2 instance to see the address of your deployment.

**make teardown**
Deletes deployment from AWS

## Local Dev

To develop locally without docker do `./gradlew run` to launch the server. Server is available at `localhost:8080`.