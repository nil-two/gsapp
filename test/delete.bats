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

@test "gsapp delete: exit non-zero if arguments is not enough" {
  run "$gsapp" delete
  [[ $status != 0 ]]
}

@test "gsapp delete: exit non-zero if \$GSAPP_PATH doesn't exist" {
  rm -rf -- "$GSAPP_PATH"
  run "$gsapp" delete name0
  [[ $status != 0 ]]
}

@test "gsapp delete: exit non-zero if the specified application doesn't exist" {
  run "$gsapp" delete name0
  [[ $status != 0 ]]
}

@test "gsapp delete: delete the specified application" {
  touch "$GSAPP_PATH/name0.desktop"
  touch "$GSAPP_PATH/name1.desktop"
  run "$gsapp" delete name1
  [[ $status == 0 ]]
  [[ -f "$GSAPP_PATH/name0.desktop" ]]
  [[ ! -f "$GSAPP_PATH/name1.desktop" ]]
}

@test "gsapp delete: delete the specified applications" {
  touch "$GSAPP_PATH/name0.desktop"
  touch "$GSAPP_PATH/name1.desktop"
  run "$gsapp" delete name0 name1
  [[ $status == 0 ]]
  [[ ! -f "$GSAPP_PATH/name0.desktop" ]]
  [[ ! -f "$GSAPP_PATH/name1.desktop" ]]
}
