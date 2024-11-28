// сервисный аккаунт
resource "yandex_iam_service_account" "service" {
  folder_id = var.folder_id
  name      = "diplom-sa"
}

// роли для сервисного аккаунта
resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.service.id}"
}

// статический ключ
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.service.id
}

resource "yandex_storage_bucket" "bucket-yakunichkina-netology" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "bucket-yakunichkina"
  acl    = "private"
  force_destroy = true
}

resource "local_file" "backend" {
  content  = <<EOT
endpoint = "storage.yandexcloud.net"
bucket = "${yandex_storage_bucket.bucket-yakunichkina-netology.bucket}"
region = "ru-central1"
key = "terraform/terraform.tfstate"
access_key = "${yandex_iam_service_account_static_access_key.sa-static-key.access_key}"
secret_key = "${yandex_iam_service_account_static_access_key.sa-static-key.secret_key}"
skip_region_validation = true
skip_credentials_validation = true
EOT
  filename = "../backend.key"
}

// поместим стейт файл в баскет
resource "yandex_storage_object" "state-file" {
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    bucket = yandex_storage_bucket.bucket-yakunichkina-netology.bucket
    key = "terraform.tfstate"
    source = "../terraform.tfstate"
    acl    = "private"
    depends_on = [yandex_storage_bucket.bucket-yakunichkina-netology]
}
