#!/bin/bash

set -e

# To build the Docker image do this
docker build -t student-testapp:latest .

# To start minikube cluster if not running do this
if ! minikube status > /dev/null 2>&1; then
    minikube start --profile=handshake-exercise
fi

# Change context to the handshake-exercise cluster
kubectl config use-context handshake-exercise

# To apply the Kubernetes manifests do this
kubectl apply -f k8s-manifest/deployment.yaml
kubectl apply -f k8s-manifest/service.yaml

#To reach the service, run this command
kubectl port-forward service/student-testapp-service 8080:80