## Architecture Diagram

This architecture diagram represents the deployment the Javelin AI Gateway Application, highlighting the infrastructure components, their relationships. It demonstrates how the deployment leverages Cloud services and resources for reliability, scalability, security, and cost-effectiveness.

![Javelin Infra](./img/architecture.png)

## Cross Region Architecture Diagram (AWS Specific)

Javelin AI Gateway can be deployed in cross region if the cloud provider meets the cross region HA requirements. The below diagram represents the cross region deployment of Javelin AI Gateway in AWS.

**ℹ️ IMPORTANT NOTICE**

The Terraform doesn't support the cross region deployment. If you are choosing cross region deployment, then please fork this repository and adjust the Terraform code accordingly to ensure that the following resources configured properly

* `AWS Application Load Balancer` cross region dns based failover setup, you can find the offical docs [here](https://docs.aws.amazon.com/whitepapers/latest/real-time-communication-on-aws/cross-region-dns-based-load-balancing-and-failover.html)

* `Postgres Active - Active Cluster` with help of `pgactive extension`, checkout the official [docs](https://aws.amazon.com/blogs/database/using-pgactive-active-active-replication-extension-for-postgresql-on-amazon-rds-for-postgresql/)

![Javelin AWS HA Infra](./img/aws-ha-architecture.png)

## Networking Diagram

The following diagram illustrates the key networking components, including VPCs, firewall, load balancers, and compute resources.

![Javelin Network](./img/networking.png)

### Key Components

* **VPC (Virtual Private Cloud)**:
    - The foundational network layer isolating resources securely. Subnets are typically segmented by availability zones (AZs) for high availability.
* **Subnets**:
    - **Public Subnets**: Hosts public-facing components like load balancers.
    - **Private Subnets**: Secured subnets for application servers, databases, and backend services, without direct internet access.
* **NAT Gateway**:
    - Allows outbound internet access for resources in private subnets.
* **Internet Gateway**:
    - Enables resources in a VPC to access the internet.
* **Load Balancer**:
    - Distributes incoming traffic across the Kubernetes deployment to ensure reliability and balance workloads.
* **Kubernetes**:
    - Cloud managed service for Kubernetes to deploy the microservices.
* **Database**:
    - We are using managed Postgres service from the cloud provider, providing persistent storage backend enabled.
* **Redis**:
    - Cloud managed Redis we are using for cache service.
* **IAM (Identity and Access Management)**:
    - Have one custom IAM role which is binding with Kubernetes service account for the specific microservice.
* **Cloud Provider Logging System**:
    - Monitoring and observability for metrics, logs, and alarms, helping maintain visibility into application health and performance.

## 🔒 Security Considerations

- All external inbound and outbound traffic is encrypted (HTTPS, TLS 1.2+)
- IAM policies enforce least privilege
- Application Logs enabled for monitoring and debugging
- Firewall open only required ports for traffic
