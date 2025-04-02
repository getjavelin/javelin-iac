########## Locals ##########
locals {
  yaml_data = <<YAML
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: ${var.storage_classname}
  annotations:
    storageclass.kubernetes.io/is-default-class: "false"
provisioner: ${var.storage_provisioner}
reclaimPolicy: Delete
allowVolumeExpansion: true
volumeBindingMode: WaitForFirstConsumer
parameters:
  fsType: ${var.fs_type}
  type: ${var.storage_type}
  tagSpecification_1: "ManagedBy=Terraform"
  tagSpecification_2: "Environment=${var.project_env}"
  tagSpecification_3: "Project=${var.project_name}"
YAML
}

########## Kubectl ##########
resource "kubernetes_manifest" "storage_class" {
    manifest = yamldecode(local.yaml_data)
}