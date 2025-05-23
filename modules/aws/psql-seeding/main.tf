########## Locals ##########
locals {
  local_sql_script                = "../../../../../config/aws/${var.project_env}/script/${var.psql_seeding_file}"
  remote_sql_script               = "/tmp/${var.psql_seeding_file}"
}

########## Remote_PostgreSQL_Seeding ##########
resource "null_resource" "remote_seeding" {
  count                           = var.remote_exec == true ? 1 : 0

  triggers                        = {
                                      policy_sha1   = "${sha1(file("${local.local_sql_script}"))}"
                                      ip_address    = var.bastion_ip
                                    }

  provisioner "file" {
    destination                   = local.remote_sql_script
    content                       = templatefile("${local.local_sql_script}", {
                                        javelin_customers_password = "${var.javelin_customers_password}"
                                        javelin_admin_password     = "${var.javelin_admin_password}"
                                    })

    connection {
        type                      = "ssh"
        host                      = var.bastion_ip
        user                      = var.bastion_user
        private_key               = file("${var.local_ssh_key}")
        timeout                   = "1m"
    }
  }

  provisioner "remote-exec" {
    inline                        = [
                                      "PGPASSWORD=${var.psql_password} psql --set=sslmode=${var.psql_sslmode} -h ${var.psql_host} -p ${var.psql_port} -U ${var.psql_username} -d ${var.psql_database} -f ${local.remote_sql_script}",
                                      "rm -rf ${local.remote_sql_script}"
                                    ]

    connection {
        type                      = "ssh"
        host                      = var.bastion_ip
        user                      = var.bastion_user
        private_key               = file("${var.local_ssh_key}")
        timeout                   = "10m"
    }
  }
}

########## Local_PostgreSQL_Seeding ##########
resource "local_file" "sql_script" {
  count                           = var.remote_exec == false ? 1 : 0
  
  filename                        = local.remote_sql_script
  content                         = templatefile("${local.local_sql_script}", {
      javelin_customers_password  = "${var.javelin_customers_password}"
      javelin_admin_password      = "${var.javelin_admin_password}"
  })
}

resource "null_resource" "local_seeding" {
  count                           = var.remote_exec == false ? 1 : 0

  triggers                        = {
                                      policy_sha1   = "${sha1(file("${local.local_sql_script}"))}"
                                    }

  provisioner "local-exec" {
    command                        = "PGPASSWORD=$PSQL_PASSWORD psql --set=sslmode=$PSQL_SSLMODE -h $PSQL_HOST -p $PSQL_PORT -U $PSQL_USERNAME -d $PSQL_DATABASE -f $REMOTE_SQL_SCRIPT ; rm -rf $REMOTE_SQL_SCRIPT"

    environment                    = {
                                        REMOTE_SQL_SCRIPT = local.remote_sql_script
                                        PSQL_PASSWORD     = var.psql_password
                                        PSQL_SSLMODE      = var.psql_sslmode
                                        PSQL_HOST         = var.psql_host
                                        PSQL_PORT         = var.psql_port
                                        PSQL_USERNAME     = var.psql_username
                                        PSQL_DATABASE     = var.psql_database
                                      }
  }
}