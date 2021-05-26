FROM nexus.cics-ts.hur.hdclab.intranet.ibm.com:8080/library/ubuntu:latest

RUN apt-get update && apt-get install -y unzip \
    curl \
    openjdk-11-jdk \
    maven \
    gpg \
    wget
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
RUN apt update && apt install -y git \
    gh

# Installing 6.8.2 version of gradle
RUN mkdir /opt/gradle
RUN curl -L https://services.gradle.org/distributions/gradle-6.8.2-bin.zip -o gradle-6.8.2-bin.zip
RUN unzip -d /opt/gradle gradle-6.8.2-bin.zip
ENV PATH=$PATH:/opt/gradle/gradle-6.8.2/bin

RUN mkdir /opt/openapi
RUN wget https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/5.1.0/openapi-generator-cli-5.1.0.jar -O /opt/openapi/openapi-generator-cli.jar

RUN mkdir /workspace
WORKDIR /workspace
