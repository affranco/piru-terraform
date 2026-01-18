terraform {
  backend "gcs" {
    bucket = "empresa-piru-tfstate" # El bucket que creaste en el paso 1
    prefix = "terraform/state"      # Carpeta dentro del bucket
  }
}
provider "google" {
  project = "156352841902" # Tu ID numérico (o el de letras si el numérico falla)
  region  = "us-central1"
}

# --- 1. Bucket Data Lake ---
resource "google_storage_bucket" "datalake_raw" {
  name     = "empresa-piru-datalake-raw"
  location = "EU"

  # Usamos var.tags como definimos antes
  labels = merge(var.tags, {
    cost-center = "data-analytics"
  })
}

# --- 2. Bucket Assets Públicos ---
resource "google_storage_bucket" "assets_publicos" {
  name     = "empresa-piru-assets-publicos"
  location = "US"

  labels = merge(var.tags, {
    cost-center = "marketing-web"
  })
}

# --- 3. Bucket Logs ---
resource "google_storage_bucket" "infra_logs" {
  name     = "empresa-piru-infra-logs-01"
  location = "US"

  labels = merge(var.tags, {
    cost-center = "infra-ops"
  })
}