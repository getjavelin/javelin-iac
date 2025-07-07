########## Locals ##########
locals {
  tag_string              = join(",", [for k, v in var.common_tags : "${k}=${v}"])
  merged_tags             = {
                              skuname             = var.storage_sku
                              kind                = "Managed"
                              cachingMode         = "None"
                              diskEncryptionSetID = var.des_id
                              tags                = local.tag_string
                            }
}

########## StorageClass ##########
resource "kubernetes_storage_class" "storage_class" {
  metadata {
    name                  = var.storage_classname
    annotations           = {
                              "storageclass.kubernetes.io/is-default-class" = "false"
                            }
  }
  allow_volume_expansion  = true
  volume_binding_mode     = "WaitForFirstConsumer"
  storage_provisioner     = var.storage_provisioner
  reclaim_policy          = "Delete"
  parameters              = local.merged_tags
}