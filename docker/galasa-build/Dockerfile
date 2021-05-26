FROM nexus.cics-ts.hur.hdclab.intranet.ibm.com:8080/library/ubuntu:latest

RUN apt-get update && apt-get install -y unzip \
    curl \
    openjdk-11-jdk \
    maven 
RUN apt install git -y

# Installing 6.8.2 version of gradle
RUN mkdir /opt/gradle
RUN curl -L https://services.gradle.org/distributions/gradle-6.8.2-bin.zip -o gradle-6.8.2-bin.zip
RUN unzip -d /opt/gradle gradle-6.8.2-bin.zip
ENV PATH=$PATH:/opt/gradle/gradle-6.8.2/bin
