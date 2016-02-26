#!/usr/bin/env bats

readonly gsapp="$BATS_TEST_DIRNAME/../gsapp"
readonly GSAPP_PATH="$BATS_TMPDIR/applications"

setup() {
  export GSAPP_PATH
  mkdir -p -- "$GSAPP_PATH"
}

teardown() {
  rm -rf -- "$GSAPP_PATH"
}

@test "gsapp list: list files whose extension is .desktop" {
  touch "$GSAPP_PATH/aaa.desktop"
  touch "$GSAPP_PATH/bbb.desktop"
  touch "$GSAPP_PATH/ccc.xml"
  run "$gsapp" list
  [[ $status == 0 ]]
  [[ ${lines[0]} == aaa ]]
  [[ ${lines[1]} == bbb ]]
}

@test "gsapp list: show nothing if \$GSAPP_PATH doesn't exist" {
  rm -rf -- "$GSAPP_PATH"
  run "$gsapp" list
  [[ $status == 0 ]]
  [[ ${#lines[@]} == 0 ]]
}
