# Cloud Components

These are the resources that we are provisioning in the cloud for setting up the Javelin

## AWS

### Resources

* VPC

    * Public subnets - for deploying the public facing resources such as ALB

    * Private subnets - for deploying the internal application such as EKS, Postgres, Redis etc..

* Aurora for Postgres

    * Required minimum 4 vCPU and 8 GB RAM, This can be changed with respect to the load in the application

    * Recommending a Global Aurora cluser for production

* Memcache for Redis

    * 4 GB RAM minimum

* EKS cluster with workernodes

    * 3 node Masternodes (managed by AWS)

    * Minimum 4 nodes with 4 vCPU and 16 GB RAM - Javelin core services

    * Minimum 8 vCPU and 32 GB RAM with GPU enabled - Javelin guard models

* CloudWatch LogGroup

* Custom IAM role and policies for accessing the bedrock from Javelin (Permissions will change based on the requirements)

* EKS Dependencies

    * ALB ingress controller

    * Custom storageclass with high IOPS

    * AutoScaler

    * FluentBit

    * Metric Server


### Permission and Communication

* EKS workernodes permissions

    * AmazonEBSCSIDriverPolicy

    * Cloudwatch access

* EKS workernodes ingress and egress

    * Postgres access internally

    * Redis access internally

    * Accept incoming request from ALB

## Azure

### Resources

* Vnet

    * Public subnets - for deploying the public facing resources such as Application Loadbalancer

    * Private subnets - for deploying the internal application such as AKS, Postgres, Redis etc..

*  Postgres Flexy Server

    * Required minimum 4 vCPU and 8 GB RAM

    * Recommending a Cross region read replica for production

*  Azure Redis Cache

    * 4 GB RAM minimum

* AKS cluster with workernodes

    * Masternodes (managed by Azure)

    * Enable logging, metrics, auto scale 

    * Mininum 2 nodes with 4 vCPU and 8 GB RAM for system nodes

    * Minimum 4 nodes with 4 vCPU and 16 GB RAM - Javelin core services

    * Minimum 8 vCPU and 32 GB RAM with GPU enabled - Javelin guard models

* Application Gateway for AKS ingress controller

* AKS Dependencies

    * Cert manager for SSL termination - optional if we are not attaching the Certificates in the Applcation Gateway

    * Custom storageclass with high IOPS

### Permission and Communication

* AKS workernodes permissions

    * Disk Encryption Sets - Reader

    * Log Analytics Workspace - Log Analytics Contributor

* Application Gateway permissions

    * ResourceGroup - Reader

    * Application Gateway - Contributor

    * Application Gateway Identity - Managed Identity Operator

    * Subnet Network - Contributor

* AKS workernodes ingress and egress

    * Postgres access internally

    * Redis access internally

    * Accept incoming request from Application Gateway