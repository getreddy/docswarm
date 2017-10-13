# docswarm

### Prerequisites
- You need 2 ubuntu nodes i.e. one host will be swarm master and other node will act as a worker node. 
- Make sure docker service is installed on the host (say ubuntu). Refer [docker setup](dockerSetup.sh) file docker service installation.


### Setup

Follow step 1 and 2 on both the nodes i.e. master and worker. 

1) Build microproj 
` git clone https://github.com/getreddy/docswarm.git`
`cd microproj` <br />
// Below command will build required jar files under microproj/build/libs <br />
`gradlew clean && gradlew build` <br />
// Container will make use of this jar file by launching command as 'java -jar docMicroservice-0.1.0.jar'<br />
` cd ..` <br/>
` mkdir jars` <br/>
` cp microproj/build/libs/docMicroservice-0.1.0.jar jars/` <br/>

2) Build docker image <br/>
 Below command will make use of [docker file](Dockerfile) <br/>
`sudo docker build -t ubuntuswarmtest .`



3) Create **overlay** network. 
  
  Docker introduced user-defined bridge networks to control which containers can communicate with each other, and also to   enable automatic DNS resolution of container names to IP addresses. 
  
  By default when we create swarm cluster, it creates overlay network “ingress” 
  
  We will create a new overlay network for our docker to docker communication. 
  
  `sudo docker network create  --attachable -d overlay overnet`
  
 3) create swarm cluster.
