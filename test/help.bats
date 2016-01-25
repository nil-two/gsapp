#!/usr/bin/env bats

readonly gsapp="$BATS_TEST_DIRNAME/../gsapp"

@test "gsapp help: show usage" {
  run "$gsapp" help
  [[ $status == 0 ]]
  [[ ${lines[0]} =~ ^usage ]]
}
