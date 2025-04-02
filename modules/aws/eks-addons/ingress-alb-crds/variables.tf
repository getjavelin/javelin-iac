variable "alb_ingress_crds_url" {
  description = "crds for ALB Ingress Controller"
  type        = string
  default     = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.2/helm/aws-load-balancer-controller/crds/crds.yaml"
}
# tag v2.7.2 using for helm chart version 1.7.2