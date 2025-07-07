## Terraform Backend Variables
resource_group_name                         = "javelin-poc"
storage_account_name                        = "javelintfstatepoc"
## Resource Variables
common_tags                                 = {
                                                ManagedBy   = "Terraform"
                                              }
az_subscription_id                          = ""
ad_object_id                                = ""
enable_delete_lock                          = true
project_name                                = "javelin"
project_env                                 = "poc"
location                                    = "East US"