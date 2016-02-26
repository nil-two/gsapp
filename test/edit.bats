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

@test "gsapp edit: exit non-zero if arguments is not enough" {
  run "$gsapp" edit
  [[ $status != 0 ]]
}

@test "gsapp edit: exit non-zero if \$GSAPP_PATH doesn't exist" {
  rm -rf -- "$GSAPP_PATH"
  run "$gsapp" edit app
  [[ $status != 0 ]]
}

@test "gsapp edit: exit non-zero if the specified application doesn't exist" {
  run "$gsapp" edit app
  [[ $status != 0 ]]
}

@test "gsapp edit: edit the specified application with \$EDITOR" {
  export EDITOR="rm"
  touch "$GSAPP_PATH/app.desktop"
  run "$gsapp" edit app
  [[ $status == 0 ]]
  [[ ! -f "$GSAPP_PATH/app.desktop" ]]
}
