#!/usr/bin/env bats

setup() {
  export CI=test
  load functions
  echo "Building image..."
  ENVIRONMENT=local_docker
  DOCKER_IMAGE="$(basename $(pwd)):test"
  docker build -t ${DOCKER_IMAGE} .
}

teardown() {
  unset_vars DOCKER_IMAGE ENVIRONMENT
}

@test "Pip installed" {
    run docker run -e ENVIRONMENT=$ENVIRONMENT -t ${DOCKER_IMAGE} \
        pip --version

    results

    [ "$status" -eq 0 ]
}

@test "ENVIRONMENT works" {
    run docker run -e ENVIRONMENT=$ENVIRONMENT -t ${DOCKER_IMAGE}

    results

    [ "$status" -eq 0 ]
    [[ "$output" =~ 'Python script running in local_docker.' ]]
}
