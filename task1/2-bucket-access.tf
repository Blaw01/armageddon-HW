
resource "google_storage_default_object_access_control" "access_control" {
  bucket = google_storage_bucket.task1.name
  role   = "READER"
  entity = "allUsers"
}


resource "google_storage_bucket_iam_binding" "public_access" {
  bucket = google_storage_bucket.task1.name
  role   = "roles/storage.objectViewer"

  members = [
    "allUsers",
  ]
}