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

@test "gsapp edit: exit 2 if arguments is not enough" {
  run "$gsapp" edit
  [[ $status == 2 ]]
}

@test "gsapp edit: exit 2 if \$GSAPP_PATH doesn't exist" {
  rm -rf -- "$GSAPP_PATH"
  run "$gsapp" edit name
  [[ $status == 2 ]]
}

@test "gsapp edit: exit 1 if the specified application doesn't exist" {
  run "$gsapp" edit name
  [[ $status == 1 ]]
}

@test "gsapp edit: edit the specified application with \$EDITOR" {
  export EDITOR="rm"
  touch "$GSAPP_PATH/name.desktop"
  run "$gsapp" edit name
  [[ $status == 0 ]]
  [[ ! -f "$GSAPP_PATH/name.desktop" ]]
}
