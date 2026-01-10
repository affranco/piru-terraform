terraform {
  cloud {
    organization = "piru"
    workspaces {
      name = "piru-terraform"
    }
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  # No ponemos credenciales aquí porque Terraform Cloud las leerá de las variables
  region  = "us-central1"
}

resource "google_storage_bucket" "mi_bucket_prueba_piru" {
  # IMPORTANTE: Cambia este nombre, debe ser único en todo el mundo (como un email)
  name          = "bucket-piru-prueba-aprender-123" 
  location      = "US"
  force_destroy = true # Esto permite borrar el bucket aunque tenga archivos dentro
}