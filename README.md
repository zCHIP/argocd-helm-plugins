# argocd-helm-plugins

ArgoCD server custom image with additional Helm plugins:
- [helm-git](https://github.com/aslafy-z/helm-git) version `0.10.0`
- [helm-diff](https://github.com/databus23/helm-diff) version `v3.1.3`

## Local build

Requirements:
- Docker

```shell
docker build \
  --build-arg ARGOCD_BASE_IMAGE="argoproj/argocd" \
  --build-arg ARGOCD_BASE_IMAGE_VERSION="v2.0.1" \
  -t argocd-helm-plugins:0.1-non-ci .
```

## CI

Requirements:
- `GHCR_PAT` repository secret with [GitHub Personal Access Token (PAT)](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) with `delete:packages`, `read:packages`, `repo`, `write:packages` scopes to push images to [GitHub Container Registry](https://docs.github.com/en/packages/guides/about-github-container-registry).
- `SLACK_WEBHOOK_URL` repository secret with a Slack [webhook URL](https://api.slack.com/messaging/webhooks) for CI notifications.

See [ci-image.yaml](.github/workflows/ci-image.yaml) workflow for additional details.
