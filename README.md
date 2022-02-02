# Terraform a Kubernetes application
Terraform is an infrastructure as code (IaC) tool that build, change, and version infrastructure safely and efficiently.
This includes:

- low-level components such as compute instances, storage, and networking

- high-level components such as DNS entries, SaaS features, etc. 

This project addresses a SAS feature and especially Kubernetes.

## Installing Kubernetes

This project requires a local installation of Kubernetes. For testing purpose MiniKube is an easy to use implementation: 
https://github.com/charroux/kubernetes-minikube

Start the Minikube cluster with: minikube start

## Installing Terraform

https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started

## Aim of this project

The main objective of this project is to compare two uses of Kubernetes: pure Kubernetes approach versus Kubernetes through Terraform.

### Pure kubernetes approach

Lets have a look at a Kubernetes configuration file: https://github.com/charroux/CodingWithKubernetes/blob/master/front-back-app.yml

A detailled version of this configuration is given at: https://github.com/charroux/CodingWithKubernetes

### Kubernetes through Terraform

The same Kubernetes deployment can be achieved using Terraform: https://github.com/charroux/TerraformKubernetes/blob/master/main.tf

A Kuberntes provider must be set in this file:
```
provider "kubernetes" {
  config_path = "~/.kube/config"
}
```
Where config_path must point to a local installation of Kubernetes.

Initialiaze Terraform with 
```
terraform init
```
Then apply Terraform
```
terraform apply
```
### Reach the Kubernetes service from outside the cluster

```
minikube service front-end-service --url
```
Then use this url in a Web browser.
### Destroy resources
Finally use
```
terraform destroy
```

