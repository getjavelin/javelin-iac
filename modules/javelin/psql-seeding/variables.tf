variable "pg_db_list" {
  description = "List of Database names"
  type        = list(string)
}

variable "pg_extentions" {
  description = "List of extentions and its databases"
  type = list(object({
    name         = string
    database     = string
  }))
}