#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# export AWS_STUB_DEBUG=/dev/tty

@test "Login to GCR" {
  export BUILDKITE_PLUGIN_GCR_LOGIN=true
  export BUILDKITE_PLUGIN_GCR_JSON_KEY=foo

  stub docker \
    'docker login -u _json_key -p "$( echo ${BUILDKITE_PLUGIN_GCR_JSON_KEY} )" https://gcr.io : echo Log in to a Docker registry'

  run $PWD/hooks/pre-command

  assert_success
  # assert_output --partial "Log in to a Docker registry"

  unstub docker
  unset BUILDKITE_PLUGIN_GCR_JSON_KEY
  unset BUILDKITE_PLUGIN_GCR_LOGIN
}
