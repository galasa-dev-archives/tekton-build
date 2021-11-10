FROM nexus.cics-ts.hur.hdclab.intranet.ibm.com:8080/library/golang

ENV RELEASE_VERSION=v0.18.2

RUN curl -LO https://github.com/operator-framework/operator-sdk/releases/download/${RELEASE_VERSION}/operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu
RUN chmod +x operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu && mkdir -p /usr/local/bin/ && cp operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu /usr/local/bin/operator-sdk && rm operator-sdk-${RELEASE_VERSION}-x86_64-linux-gnu