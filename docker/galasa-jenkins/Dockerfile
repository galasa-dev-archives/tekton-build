FROM nexus.cics-ts.hur.hdclab.intranet.ibm.com:8080/galasadev/jenkins-jnlp:1.0.1

USER root

# Installing kubectl
RUN mkdir -p /opt/k8s/bin
RUN curl -L https://dl.k8s.io/release/v1.20.0/bin/linux/amd64/kubectl -o /opt/k8s/bin/kubectl
RUN chmod +x /opt/k8s/bin/kubectl

RUN curl -L https://github.com/tektoncd/cli/releases/download/v0.18.0/tkn_0.18.0_Linux_x86_64.tar.gz -o /opt/k8s/tkn.tar.gz
RUN tar -xvf /opt/k8s/tkn.tar.gz --directory /opt/k8s/bin
RUN chmod +x /opt/k8s/bin/tkn
ENV PATH=$PATH:/opt/k8s/bin

RUN apt-get update && apt-get install -y jq \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
    
COPY checkprun /opt/k8s/bin
RUN  chmod +x /opt/k8s/bin/checkprun

USER jenkins