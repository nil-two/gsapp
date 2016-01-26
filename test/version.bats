#!/usr/bin/env bats

readonly gsapp="$BATS_TEST_DIRNAME/../gsapp"

@test "gsapp verison: show version" {
  run "$gsapp" version
  [[ $status == 0 ]]
  [[ ${lines[0]} =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
}
