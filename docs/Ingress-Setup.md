# Javelin K8s Ingress Setup Reference 

The Javelin components are deploying as a microservices in the Kubernetes, there we will use the ingress controller provided by the cloud provider. the ingress configuration will change with respect to the cloud provider we are using and the following sample template we can consider as a reference for setting the ingress for the javelin components.

## AWS

```code
ingress:
  enabled: true
  className: "alb"
  annotations:
    alb.ingress.kubernetes.io/scheme: internet-facing
    alb.ingress.kubernetes.io/healthcheck-protocol: HTTP 
    alb.ingress.kubernetes.io/healthcheck-port: traffic-port
    alb.ingress.kubernetes.io/target-type: instance
    alb.ingress.kubernetes.io/ssl-redirect: '443'
    alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS": 443}]'
    alb.ingress.kubernetes.io/healthcheck-interval-seconds: '15'
    alb.ingress.kubernetes.io/healthcheck-timeout-seconds: '5'
    alb.ingress.kubernetes.io/healthy-threshold-count: '2'
    alb.ingress.kubernetes.io/unhealthy-threshold-count: '2'
    alb.ingress.kubernetes.io/success-codes: '200'
    alb.ingress.kubernetes.io/group.order: '2'
    alb.ingress.kubernetes.io/load-balancer-attributes: "idle_timeout.timeout_seconds=300"

    alb.ingress.kubernetes.io/load-balancer-name: ${K8S_CLUSTER_NAME}-alb-ingress
    alb.ingress.kubernetes.io/group.name: ${K8S_CLUSTER_NAME}-group
    alb.ingress.kubernetes.io/subnets: ${PUBLIC_SUBNET_IDS}
    alb.ingress.kubernetes.io/certificate-arn: ${ACM_CERTIFICATE_ARN}
    alb.ingress.kubernetes.io/security-groups: ${ALB_SECURITY_GROUP_IDS}
  hosts:
    - host: javelin.domain.name
      paths:
        - path: /v1/admin/
          pathType: Prefix
```

## Azure

* With Application Gateway SSL Certificate

```code
ingress:
  enabled: true
  className: "azure-application-gateway"
  annotations:
    appgw.ingress.kubernetes.io/use-private-ip: "false"
    appgw.ingress.kubernetes.io/ssl-redirect: "true"
    appgw.ingress.kubernetes.io/appgw-ssl-certificate: "self-signed"
    appgw.ingress.kubernetes.io/backend-protocol: "http"
    appgw.ingress.kubernetes.io/request-timeout: "300"
    appgw.ingress.kubernetes.io/health-probe-path: "/v1/admin/healthz"
    appgw.ingress.kubernetes.io/health-probe-status-codes: "200"
    appgw.ingress.kubernetes.io/health-probe-interval: "15"
    appgw.ingress.kubernetes.io/health-probe-timeout: "5"
    appgw.ingress.kubernetes.io/health-probe-unhealthy-threshold: "2"
  hosts:
    - host: javelin.domain.name
      paths:
        - path: /v1/admin/
          pathType: Prefix
```

* With Certbot SSL Certificate

```code
ingress:
  enabled: true
  className: "azure-application-gateway"
  annotations:
    appgw.ingress.kubernetes.io/use-private-ip: "false"
    appgw.ingress.kubernetes.io/ssl-redirect: "true"
    cert-manager.io/cluster-issuer: letsencrypt-prod
    appgw.ingress.kubernetes.io/backend-protocol: "http"
    appgw.ingress.kubernetes.io/request-timeout: "300"
    appgw.ingress.kubernetes.io/health-probe-path: "/v1/admin/healthz"
    appgw.ingress.kubernetes.io/health-probe-status-codes: "200"
    appgw.ingress.kubernetes.io/health-probe-interval: "15"
    appgw.ingress.kubernetes.io/health-probe-timeout: "5"
    appgw.ingress.kubernetes.io/health-probe-unhealthy-threshold: "2"
  tls:
    - hosts:
        - javelin.domain.name
      secretName: javelin-admin-tls
  hosts:
    - host: javelin.domain.name
      paths:
        - path: /v1/admin/
          pathType: Prefix
```