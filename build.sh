#!/usr/bin/env bash
latest=true
#deploy="false"
deploy="true"
image=mediatools
version=0.3

#OPTIONS="--no-cache --force-rm"
#OPTIONS="--no-cache"
#OPTIONS="--force-rm"
OPTIONS=""

docker build ${OPTIONS} -t ivonet/${image}:${version} .
if [ "$?" -eq 0 ] && [ ${deploy} == "true" ]; then
    docker push ivonet/${image}:${version}
    if [ "$latest" == "true" ]; then
        docker tag ivonet/${image}:${version} ivonet/${image}:latest
        docker push ivonet/${image}:latest
    fi
fi
