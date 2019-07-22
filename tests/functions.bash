#!/usr/bin/env bash

results() {
    echo "Status: $status"
    echo "Output: $output"
}

unset_vars() {
  arr=($@)
  for v in ${arr[@]}; do
    echo "# unset: $v" && unset $v
  done
}