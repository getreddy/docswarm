FROM ubuntu
RUN apt-get update && apt-get install -y iputils-ping
RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository -y ppa:webupd8team/java
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get update
RUN apt-get -y install oracle-java8-installer
ADD jars /opt/jars
CMD bash
