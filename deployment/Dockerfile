FROM alpine

ARG HELM_VERSION=3.2.1
ARG KUBECTL_VERSION=1.17.5

# Install helm
ENV BASE_URL="https://get.helm.sh"
ENV TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"

RUN echo "Installing HELM"
RUN apk add --update --no-cache curl ca-certificates bash git && \
    curl -sL ${BASE_URL}/${TAR_FILE} | tar -xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64

RUN echo "Installing Kubectl"
RUN curl -sLO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]