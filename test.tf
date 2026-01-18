terraform {
  backend "gcs" {
    bucket = "empresa-piru-tfstate"
    prefix = "terraform/state"
  }
}

provider "google" {
  region = "us-central1"
}

variable "tags" {
  description = "Etiquetas por defecto"
  type        = map(string)
  default = {
    cost-center = "infra-general"
    environment = "production"
    managed-by  = "terraform"
  }
}

# --- 1. Bucket Data Lake ---
resource "google_storage_bucket" "datalake_raw" {
  name          = "empresa-piru-datalake-raw"
  location      = "US"
  force_destroy = true

  labels = merge(var.tags, {
    cost-center = "data-analytics"
  })
}

# --- 2. Bucket Assets ---
resource "google_storage_bucket" "assets_publicos" {
  name          = "empresa-piru-assets-publicos"
  location      = "US"
  force_destroy = true

  labels = merge(var.tags, {
    cost-center = "marketing-web"
  })
}

# --- LA TRAMPA PARA TRIVY ---
# Este recurso es sintácticamente correcto, pero INSEGURO.
# Trivy detectará que estamos dando acceso a "allUsers" y bloqueará el despliegue.
resource "google_storage_bucket_iam_member" "public_access" {
  bucket = google_storage_bucket.datalake_raw.name
  role   = "roles/storage.objectViewer"
  member = "allUsers" # <--- ¡ALERTA CRÍTICA! 🚨
}