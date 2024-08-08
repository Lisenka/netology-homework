## Задание 1. Yandex Cloud   

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

 - создать ключ в KMS;
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.

### Ответ:

1. В [bucket.tf](/cloud_03/cloud-terraform/bucket.tf) добавляем конструкции:

```
resource "yandex_resourcemanager_folder_iam_member" "sa-editor-encrypter-decrypter" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.service.id}"
}
```

```
resource "yandex_kms_symmetric_key" "key-a" {
  name              = "key-a"
  default_algorithm = "AES_256"
  rotation_period   = "168h"
}
```

```
resource "yandex_storage_bucket" "yakunichkina" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = local.bucket_name
  acl    = "public-read"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key-a.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
```
При обращении к содержимому бакета получаем:

![Task1](/cloud_03/task1_1.jpg "Задание 1")