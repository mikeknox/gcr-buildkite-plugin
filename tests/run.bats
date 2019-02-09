#!/usr/bin/env bats

load '/usr/local/lib/bats/load.bash'

# export AWS_STUB_DEBUG=/dev/tty

@test "Login to GCR" {
  export BUILDKITE_PLUGIN_GCR_LOGIN=true
  export BUILDKITE_PLUGIN_GCR_JSON_KEY=foo

  stub docker \
    "login -u _json_key -p foo https://gcr.io : echo Login Succeeded"

  run $PWD/hooks/pre-command

  assert_success
  assert_output --partial "Login Succeeded"

  unstub docker
  unset BUILDKITE_PLUGIN_GCR_JSON_KEY
  unset BUILDKITE_PLUGIN_GCR_LOGIN
}

@test "Login to GCR with a multiline key" {
  export DOCKER_STUB_DEBUG=/dev/stdout
  export BUILDKITE_PLUGIN_GCR_LOGIN=true
  export BUILDKITE_PLUGIN_GCR_JSON_KEY="foo
  bar
  and another line"

  stub docker \
    "login -u _json_key -p 'foo\\n  bar\\n  and another line' https://gcr.io : echo Login Succeeded"

  run $PWD/hooks/pre-command

  assert_success
  assert_output --partial "Login Succeeded"

  unstub docker
  unset BUILDKITE_PLUGIN_GCR_JSON_KEY
  unset BUILDKITE_PLUGIN_GCR_LOGIN
}