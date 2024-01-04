locals {
  project_name = "netology-develop-platform"
  db = "db"
  web = "web"
  vm_web_platform_name = "${ local.project_name }-${ local.web }"
  vm_db_platform_name  = "${ local.project_name }-${ local.db }"
}
