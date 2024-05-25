# Output the self-link URL of the index HTML object
output "website_url" {
  value = "https://storage.googleapis.com/${google_storage_bucket.task1.name}/index.html"
}