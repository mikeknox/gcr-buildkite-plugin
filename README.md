# GCR Buildkite Plugin

__This is designed to run with Buildkite Agent v3.x beta. Plugins are not yet supported in Buildkite Agent v2.x.__

Login to GCR in your build steps.

This is derived from the ECR login plugin

Expects BUILDKITE_PLUGIN_GCR_JSON_KEY to be populated from your pipelines secrets. See:
https://github.com/buildkite-plugins/s3-secrets-buildkite-plugin

Also see if https://github.com/buildkite-plugins/docker-login-buildkite-plugin works for you.

## Example

This will login docker to GCR prior to running your script.

```yml
steps:
  - command: ./run_build.sh
    plugins:
      - mikeknox/gcr#v1.0.1:
        login: true
```

## Options

### `login`

Whether to login to GCR.

## License

MIT (see [LICENSE](LICENSE))
