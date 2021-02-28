# argocd-helm-plugins

ArgoCD server custom image with additional Helm plugins:
- [helm-git](https://github.com/aslafy-z/helm-git) version `0.10.0`

## Local build

Requirements:
- Docker

```shell
docker build \
  --build-arg ARGOCD_BASE_IMAGE="argoproj/argocd" \
  --build-arg ARGOCD_BASE_IMAGE_VERSION="v1.8.6" \
  -t argocd-helm-plugins:0.1-non-ci .
```

## CI

Requirements:
- `SLACK_WEBHOOK_URL` repository secret with a Slack [webhook URL](https://api.slack.com/messaging/webhooks) for CI notifications.

See [ci-image.yaml](.github/workflows/ci-image.yaml) workflow for additional details.
