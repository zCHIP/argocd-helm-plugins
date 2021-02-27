ARG ARGOCD_BASE_IMAGE="argoproj/argocd"
ARG ARGOCD_BASE_IMAGE_VERSION="v1.8.6"
FROM ${ARGOCD_BASE_IMAGE}:${ARGOCD_BASE_IMAGE_VERSION}

USER root

RUN apt-get update && \
    apt-get install -y \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER argocd

ARG HELM_GIT_PLUGIN_VERSION="0.10.0"
ARG HELM_GIT_PLUGIN_REPO="https://github.com/aslafy-z/helm-git"

RUN helm plugin install ${HELM_GIT_PLUGIN_REPO} --version ${HELM_GIT_PLUGIN_VERSION}

ENV HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/"
