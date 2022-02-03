ARG ARGOCD_BASE_IMAGE="quay.io/argoproj/argocd"
ARG ARGOCD_BASE_IMAGE_VERSION="v2.2.3"

ARG HELM_GIT_PLUGIN_VERSION="0.11.1"
ARG HELM_DIFF_PLUGIN_VERSION="v3.4.0"
ARG HELM_GIT_PLUGIN_REPO="https://github.com/aslafy-z/helm-git"
ARG HELM_DIFF_PLUGIN_REPO="https://github.com/databus23/helm-diff"

ARG CUSTOM_TOOL_HELMFILE_VERSION="v0.143.0"
ARG CUSTOM_TOOL_HELMFILE_REPO="https://github.com/roboll/helmfile/releases/download"
ARG CUSTOM_TOOL_HELMFILE_WRAPPER_REPO="https://raw.githubusercontent.com/travisghansen/argo-cd-helmfile/master/src/argo-cd-helmfile.sh"

FROM ${ARGOCD_BASE_IMAGE}:${ARGOCD_BASE_IMAGE_VERSION}

USER root

RUN apt-get update && \
    apt-get install -y \
        curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -o /usr/local/bin/argo-cd-helmfile.sh -L ${CUSTOM_TOOL_HELMFILE_WRAPPER_REPO} && \
    chmod +x /custom-tools/argo-cd-helmfile.sh && \
    curl -o /usr/local/bin/helmfile -L ${CUSTOM_TOOL_HELMFILE_REPO}/${CUSTOM_TOOL_HELMFILE_VERSION}/helmfile_linux_amd64 && \
    chmod +x /usr/local/bin/helmfile

USER argocd

RUN helm plugin install ${HELM_GIT_PLUGIN_REPO} --version ${HELM_GIT_PLUGIN_VERSION}
RUN helm plugin install ${HELM_DIFF_PLUGIN_REPO} --version ${HELM_DIFF_PLUGIN_VERSION}

ENV HELM_PLUGINS="/home/argocd/.local/share/helm/plugins/"
