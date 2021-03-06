# Goal
- Launch microservice using docker service 
- Use overlay networks
- Discovering containers 

## Prerequisites
- You need 2 ubuntu nodes i.e. one host will be swarm master and other node will act as a worker node. 
- Make sure docker service is installed on both the hosts . Refer [docker setup](dockerSetup.sh) file docker service installation.


## Setup

Follow step 1 and 2 on both the nodes i.e. master and worker. 

1) **Build microservice** project <br/>
` git clone https://github.com/getreddy/docswarm.git` <br/>
`cd microproj` <br />
// Below command will build required jar files under microproj/build/libs <br />
`gradlew clean && gradlew build` <br />
// Container will make use of this jar file by launching command as 'java -jar docMicroservice-0.1.0.jar'<br />
` cd ..` <br/>
` mkdir jars` <br/>
` cp microproj/build/libs/docMicroservice-0.1.0.jar jars/` <br/>

2) Build **docker image** <br/>
 Below command will make use of [docker file](Dockerfile) <br/>
`sudo docker build -t ubuntuswarmtest .`



3) Create **overlay** network. 
  
  Docker introduced user-defined bridge networks to control which containers can communicate with each other, and also to   enable automatic DNS resolution of container names to IP addresses. 
  
  By default when we create swarm cluster, it creates overlay network “ingress” 
  
  We will create a new overlay network for our docker to docker communication. 
  
  `sudo docker network create  --attachable -d overlay overnet`
  
 4) create **swarm cluster**. <br/>
Run below command on master node : <br/>
`sudo docker swarm init` <br/>
copy and paste output of below command on worker node. <br/>
`sudo docker swarm join-token worker` <br/>
confirm the setup by running the below command on master node: <br/>
` sudo docker node ls` <br/> 


## Launch a Microservice

You can launch a service as a docker service. A service will be the image for a microservice within the context of some larger application. Examples of services might include an HTTP server, a database, or any other type of executable program that you wish to run in a distributed environment. This service which we are launching is a simple microservice which just returns a "message" when you hit "curl http://servicename:8080. In below command, the service name is "systemservice".

You have 2 options of launching docker service. <br/>
1) Using docker command line:
Run below command on master node: <br/>

`sudo docker service create --network overnet --detach=true --replicas 2 --publish 8080:8080 --name systemservice  ubuntuswarmtest  java -jar /opt/jars/docMicroservice-0.1.0.jar` <br/>

2) Using **docker-compose** : <br/>
using checked in [docker compose yml file](docker-compose.yml), run below command to launch services: <br/>

`sudo docker stack deploy --compose-file docker-compose.yml stackdemo`


When you deploy the service to the swarm, the swarm manager accepts your service definition as the desired state for the service. Then it schedules the service on nodes in the swarm as one or more replica (in above command its 2) tasks. The tasks run independently of each other on nodes in the swarm.  <br/>

## Discovering containers on the same service or stack

A container can always discover other containers on the same stack using just the container name as hostname. This includes containers of the same service. Similarly, a container can always discover other services on the same stack using the service name. <br/>

Below is the example on how a new container launched under a same overlay network can **discover** above created service: <br/>
Launch a container: <br/>

`sudo docker run -it --network="overnet" ubuntuswarmtest /bin/bash` <br/>
On the container prompt run: <br/>
`curl http://systemservice:8080` you should see below output from the service: <br/>
"Service...Root index API returned..need to work on build:-)"  <br/>









