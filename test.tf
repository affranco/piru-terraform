terraform {
  backend "gcs" {
    bucket  = "empresa-piru-tfstate"  # El bucket del estado (NO TOCAR)
    prefix  = "terraform/state"
  }
}

provider "google" {
  region = "us-central1"
  # project = "compact-env-197522" # (Opcional si ya lo toma del entorno)
}

# --- Declaración de variables ---
variable "tags" {
  description = "Etiquetas por defecto (Centro de Costo General, Ambiente, etc)"
  type        = map(string)
  
  default = {
    cost-center = "infra-general"
    environment = "production"
    managed-by  = "terraform"
  }
}

# --- 1. Bucket Data Lake (Centro de costo: Analítica) ---
resource "google_storage_bucket" "datalake_raw" {
  name          = "empresa-piru-datalake-raw"
  location      = "US"
  force_destroy = true # Útil para pruebas, permite borrar bucket con datos

  # Fusionamos las etiquetas comunes con la específica de este bucket
  labels = merge(var.tags, {
    cost-center = "data-analytics" 
  })
}

# --- 2. Bucket Assets (Centro de costo: Marketing) ---
resource "google_storage_bucket" "assets_publicos" {
  name          = "empresa-piru-assets-publicos"
  location      = "US"
  force_destroy = true

  # Sobreescribimos el cost-center para este recurso
  labels = merge(var.tags, {
    cost-center = "marketing-web"
  })
}