output "bucket_url" {
  description = "La URL base del bucket creado"
  value       = google_storage_bucket.bucket_estandar.url
}

output "bucket_name" {
  description = "El nombre del bucket creado"
  value       = google_storage_bucket.bucket_estandar.name
}