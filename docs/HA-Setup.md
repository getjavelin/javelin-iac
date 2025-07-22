# HA Setup across the Cloud

## 🏗️ Deployment Architecture

This Javelin Gateway application deployment, including considerations and implications:

1. Standalone Mode

* Single-region deployment

* Suitable for development, test environments, or non-critical workloads

* No cross-region failover or redundancy

2. High Availability (HA) / Disaster Recovery (DR) Mode

* Active-Passive deployment across two different regions

* Designed for high uptime, fault tolerance, and business continuity

* Suitable for production

The HA deployment setup is strongly depend on the cloud we are chooing as the services provided by the cloud may different from one to another.

## 🌍 Multi-Region HA Deployment

In HA mode, the application is deployed across two cloud regions (e.g., `East US` and `West US`) for redundancy and disaster recovery.

### ✅ Prerequisites for HA

Both regions must support:

* Required VM sizes, managed services, and resource

* Replication mechanisms for stateful components

### 🔁 Active-Passive Model

* Primary region handles live traffic

* Secondary region remains on standby (warm)

* Failover is manual or automated via health checks

## ⚠️ Cloud Platform Considerations

### AWS Cloud

* AWS support Aurora Global database which can be distributed across the region, The failover is faster and can be managed it with less effort

* AWS having Global accelerator for managing the load balancing between 2 region

* Global accelerator support only public endpoints, no private ip allocation

* The backend for Global accelerator which is ALB ingress controller mush be public ALB, not private ALB

* Periodically simulate region failures and validation of the DR setup can be done without distroying the resources

### Azure Cloud

* Azure doesn't support Globala database and it support only reader deployment across the region. The failover will be difficult to manage it via Iac as the reader become standalone master node and detach from the cluster once teh failover happen and there is no option to join it back with the same cluster. the only option to make the primary region as the secondary region and create a new reader from the existing master (second region database server) in the old primary region

* Exploring a good solution for global load balancing...

* The simulation of the periodic DR recovery require more work and need to recreate some resources such as Database server and tract it under the Iac by importing its statefile into the Terraform code (Only if we need ot manage it from the IaC). 

# DR RunBook

## AWS Disaster Recovery (DR) Runbook

The DR setup in is an `active - passive cluster` in 2 different regions, where active region serves READ/WRITE traffic and passive region can serve READ traffic. The switchover of passive to active can be setup Auto or Manual.

These are the steps we have to follow in manual DR process

* Do failover in the Aurora Global DB - this will switch the primary node and standby node across the region so the second region become read and write and first region will be read only

* Update the `Traffic dial` in the Global accelerator's `Endpoint groups` as below -  This can be done either via terraform or AWS console.

    * `active region` - Traffic dial must be `100`

    * `passive region` - Traffic dial must be `0`


## Azure Disaster Recovery (DR) Runbook

The DR setup in is an `active - passive cluster` in 2 different regions, where active region serves READ/WRITE traffic and passive region can serve READ traffic. The switchover of passive to active can be setup Auto or Manual.

The following steps are mandatory for the manual DR process

* Do manual failover in the Azure postgres DB - This will promote the reader postgres in the second region as a standalone primary node and it will detach from the primary region 

* The region 1 database will no longer useful as it can not be attached back to the existing primary node. to create anotehr reader in the region 1, you have to manually setup the reader from the region 2 node to region 1. so the primary will be in region 2 and reader will be in region 1.