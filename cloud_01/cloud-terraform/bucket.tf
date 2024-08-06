locals {
    current_timestamp = timestamp()
    date = formatdate("DD-MM-YYYY", local.current_timestamp)
    bucket_name = "yakunichkina-${local.date}"
}

// сервисный аккаунт
resource "yandex_iam_service_account" "service" {
  folder_id = var.folder_id
  name      = "bucket-sa"
}

// роли для сервисного аккаунта
resource "yandex_resourcemanager_folder_iam_member" "bucket-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.service.id}"
  depends_on = [yandex_iam_service_account.service]
}

// статический ключ
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.service.id
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "yakunichkina" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = local.bucket_name
  acl    = "public-read"
}

resource "yandex_storage_object" "fox" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = local.bucket_name
  key    = "fox.jpg"
  source = "~/fox.jpg"
  acl = "public-read"
  depends_on = [yandex_storage_bucket.yakunichkina]
}
