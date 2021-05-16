ARG ARGOCD_BASE_IMAGE="quay.io/argoproj/argocd"
ARG ARGOCD_BASE_IMAGE_VERSION="v2.0.1"
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

ARG HELM_DIFF_PLUGIN_VERSION="v3.1.3"
ARG HELM_DIFF_PLUGIN_REPO="https://github.com/databus23/helm-diff"

RUN helm plugin install ${HELM_GIT_PLUGIN_REPO} --version ${HELM_GIT_PLUGIN_VERSION}
RUN helm plugin install ${HELM_DIFF_PLUGIN_REPO} --version ${HELM_DIFF_PLUGIN_VERSION}

ENV HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/"
