# Define a Google Cloud Storage (GCS) bucket resource
resource "google_storage_bucket" "task1" {
  name          = "armageddon007"
  storage_class = "standard"    # Set the storage class for the bucket
  location      = "us-central1" # Define the location for the bucket
  labels = {
    "env" = "armageddon" # Add environment label to the bucket
    "dep" = "5-5class"   # Add deployment label to the bucket
  }
  #uniform_bucket_level_access = true  # Enable uniform bucket-level access

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}

# Define a Google Cloud Storage (GCS) bucket object for an HTML file
resource "google_storage_bucket_object" "objects1" {
  name         = "index.html"                     # Set the name of the object
  bucket       = google_storage_bucket.task1.name # Specify the bucket name
  source       = "${path.module}/index.html"
  content_type = "text/html" # Define the relative source file path for the object
}


# Define a Google Cloud Storage (GCS) bucket object for a picture
resource "google_storage_bucket_object" "background" {
  name         = "background.jpeg"                # Set the name of the object
  bucket       = google_storage_bucket.task1.name # Specify the bucket name
  source       = "${path.module}/background.jpeg"
  content_type = "image/jpeg" # Define the relative source file path for the object
}