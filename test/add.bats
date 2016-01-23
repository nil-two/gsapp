#!/usr/bin/env bats

readonly gsapp="$BATS_TEST_DIRNAME/../gsapp"
readonly GSAPP_PATH="$BATS_TMPDIR/application"

setup() {
  export GSAPP_PATH
  mkdir -p -- "$GSAPP_PATH"
}

teardown() {
  rm -rf -- "$GSAPP_PATH"
}

@test "exit 2 if arguments is not enough" {
  local name='test0'
  run "$gsapp" add "$name"
  [[ $status == 2 ]]
  [[ ! -e "$GSAPP_PATH/$name.desktop" ]]
}

@test "add .desktop file" {
  local name='test000'
  local execute='echo Hello'
  run "$gsapp" add "$name" "$execute"
  [[ $status == 0 ]]
  [[ -e "$GSAPP_PATH/$name.desktop" ]]
}

@test "add .desktop file which name is empty" {
  local name=''
  local execute='echo'
  run "$gsapp" add "$name" "$execute"
  [[ $status == 0 ]]
  [[ -e "$GSAPP_PATH/.desktop" ]]
}
