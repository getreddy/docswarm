# docswarm

### Prerequisites

- Make sure docker service is installed on the host (say ubuntu). Refer [docker setup](dockerSetup.sh) file docker service installation.

### Setup

1) Build microproj 

'cd microproj'
// Below command will build required jar files under microproj/build/libs
'gradlew clean && gradlew build' 
// Container will make use of this jar file by launching command as 'java -jar docMicroservice-0.1.0.jar'


2) Create **overlay** network. 
  
  Docker introduced user-defined bridge networks to control which containers can communicate with each other, and also to   enable automatic DNS resolution of container names to IP addresses. 
  
  By default when we create swarm cluster, it creates overlay network “ingress” 
  
  We will create a new overlay network for our docker to docker communication. 
  
  `sudo docker network create  --attachable -d overlay overnet`
  
 3) create swarm cluster.
