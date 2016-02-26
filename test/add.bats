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

@test "gsapp add: exit non-zero if arguments is not enough" {
  run "$gsapp" add app
  [[ $status != 0 ]]
  [[ ! -e "$GSAPP_PATH/app.desktop" ]]
}

@test "gsapp add: exit non-zero if \$GSAPP_PATH doesn't exist" {
  rm -rf -- "$GSAPP_PATH"
  run "$gsapp" add app gnome-terminal
  [[ $status != 0 ]]
  [[ ! -e "$GSAPP_PATH/app.desktop" ]]
}

@test "gsapp add: exit non-zero if .desktop file has already exist" {
  touch "$GSAPP_PATH/app.desktop"
  run "$gsapp" add app gnome-terminal
  [[ $status != 0 ]]
  [[ -e "$GSAPP_PATH/app.desktop" ]]
  [[ -z "$(cat "$GSAPP_PATH/app.desktop")" ]]
}

@test "gsapp add: add .desktop file" {
run "$gsapp" add app gnome-terminal
  [[ $status == 0 ]]
  [[ -e "$GSAPP_PATH/app.desktop" ]]
}

@test "gsapp add: add .desktop file which name is empty" {
  run "$gsapp" add '' gnome-terminal
  [[ $status == 0 ]]
  [[ -e "$GSAPP_PATH/.desktop" ]]
}

@test "gsapp add: Use \$1 as Name, and use \${*:2} as Exec" {
  run "$gsapp" add app gnome-terminal -e '"vim \"java tea\""'
  [[ $status == 0 ]]
  [[ -e "$GSAPP_PATH/app.desktop" ]]

  run cat "$GSAPP_PATH/app.desktop"
  [[ $status == 0 ]]
  [[ ${lines[0]} == '[Desktop Entry]' ]]
  [[ ${lines[1]} == 'Name=app' ]]
  [[ ${lines[2]} == 'Exec=gnome-terminal -e "vim \"java tea\""' ]]
  [[ ${lines[3]} == 'Type=Application' ]]
}
