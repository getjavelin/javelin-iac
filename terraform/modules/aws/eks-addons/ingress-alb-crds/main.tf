########## Kubernetes_Crds ##########
data "http" "manifestfile" {
  url            = var.alb_ingress_crds_url
}

locals {
  yaml_documents = split("---", data.http.manifestfile.response_body)
}

resource "kubernetes_manifest" "alb_crds" {
  count          = length(local.yaml_documents)
  manifest       = yamldecode(local.yaml_documents[count.index])
}