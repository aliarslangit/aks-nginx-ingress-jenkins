#!/bin/bash
curl -o kubectl https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
kubectl version --short --client

#Connect to EKS cluster

az aks get-credentials --name $1 --resource-group $2

#aws eks --region us-west-1 update-kubeconfig --name $1
kubectl get nodes
#Fetch Kubernetes version
kubectl version --short | tail -1 | awk '{print $NF}' | awk -F . '{print $2}'

#Adding Path 
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc