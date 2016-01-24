#!/usr/bin/env bats

readonly gsapp="$BATS_TEST_DIRNAME/../gsapp"

@test "can execute" {
  run test -x "$gsapp"
  [[ $status == 0 ]]
}

@test "show usage if there is no arguments" {
  run "$gsapp"
  [[ $status == 2 ]]
  [[ ${lines[0]} =~ ^usage ]]
}
