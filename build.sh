#!/bin/bash

DOCKER_USER=$(docker info | sed '/Username:/!d;s/.* //');

echo "Building dash-encoder"
docker build -t streaming-demo-encoder ./video-encoder

echo "Building backend app"
docker build -t streaming-demo-backend ./backend

echo "Building frontend app"
docker build -t streaming-demo-frontend ./frontend


if [ $DOCKER_USER ]
then
    echo "Pushing dash-encoder"
    docker tag streaming-demo-encoder $DOCKER_USER/streaming-demo-encoder
    docker push $DOCKER_USER/streaming-demo-encoder
    echo "Pushing backend app"
    docker tag streaming-demo-backend $DOCKER_USER/streaming-demo-backend
    docker push $DOCKER_USER/streaming-demo-backend
    echo "Pushing frontend app"
    docker tag streaming-demo-frontend $DOCKER_USER/streaming-demo-frontend
    docker push $DOCKER_USER/streaming-demo-frontend
else
    echo "User not logged in: skip pushing docker images to Dockerhub"
fi

echo "Done!"