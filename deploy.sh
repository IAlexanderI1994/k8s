#!/usr/bin/env bash

docker build -t alexkir1994/multi-client:latest -t alexkir1994/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t alexkir1994/multi-server:latest -t alexkir1994/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t alexkir1994/multi-worker:latest -t alexkir1994/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push alexkir1994/multi-client:latest
docker push alexkir1994/multi-server:latest
docker push alexkir1994/multi-worker:latest

docker push alexkir1994/multi-client:$SHA
docker push alexkir1994/multi-server:$SHA
docker push alexkir1994/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alexkir1994/multi-server:$SHA
kubectl set image deployments/client-deployment client=alexkir1994/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alexkir1994/multi-worker:$SHA

