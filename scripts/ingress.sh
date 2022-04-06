#!/bin/bash




# Create a namespace for your ingress resources if not exist
#kubectl create namespace ingress-basic

# Add the official stable repository
 

# Use Helm to deploy an NGINX ingress controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/cloud/deploy.yaml
