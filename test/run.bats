#!/usr/bin/env bats

readonly gsapp="$BATS_TEST_DIRNAME/../gsapp"

@test "gsapp: can execute" {
  run test -x "$gsapp"
  [[ $status == 0 ]]
}

@test "gsapp: show usage if there is no arguments" {
  run "$gsapp"
  [[ $status != 0 ]]
  [[ ${lines[0]} =~ ^usage ]]
}
