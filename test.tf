terraform {
  backend "gcs" {
    bucket  = "empresa-piru-tfstate"  # El nombre exacto de tu bucket nuevo
    prefix  = "terraform/state"       # Carpeta donde se guardará el archivo
  }
}

provider "google" {
  region = "us-central1"
}

# Declaración de variables
variable "tags" {
  description = "Etiquetas por defecto (Centro de Costo General, Ambiente, etc)"
  type        = map(string)
  
  default = {
    cost-center = "infra-general"  # Valor por defecto si no se especifica otro
    environment = "production"
    managed-by  = "terraform"
  }
}

# --- 1. Bucket Data Lake (Centro de costo: Analítica) ---
resource "google_storage_bucket" "datalake_raw" {
  name          = "empresa-piru-datalake-raw"
  location      = "EU"
  
  # Fusionamos las etiquetas comunes con la específica de este bucket
  labels = merge(var.tags, {
    cost-center = "data-analytics" 
  })
}

# --- 2. Bucket Assets (Centro de costo: Marketing) ---
resource "google_storage_bucket" "assets_publicos" {
  name          = "empresa-piru-assets-publicos"
  location      = "US"

  # Sobreescribimos el cost-center para este recurso
  labels = merge(var.tags, {
    cost-center = "marketing-web"
  })
}

# --- 3. Bucket Logs (Centro de costo: Infra) ---
resource "google_storage_bucket" "infra_logs" {
  name          = "empresa-piru-infra-logs-01"
  location      = "US"

  # Aquí quizás usamos el default o forzamos uno de infra
  labels = merge(var.tags, {
    cost-center = "infra-ops"
  })
}