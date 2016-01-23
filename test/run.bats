#!/usr/bin/env bats

readonly gsapp="$BATS_TEST_DIRNAME/../gsapp"

@test "can execute" {
  run test -x "$gsapp"
  [[ $status == 0 ]]
}
