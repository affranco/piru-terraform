variable "project_id" {
  description = "El ID del proyecto"
  type        = string
}

variable "sufijo" {
  description = "La parte única del nombre (lo que va después de empresa-piru-)"
  type        = string
}

variable "location" {
  description = "La región"
  type        = string
  default     = "US"
}

variable "tags" {
  description = "Etiquetas por defecto (Centro de Costo General, Ambiente, etc)"
  type        = map(string)
  
  default = {
    cost-center = "infra-general"  # Valor por defecto si no se especifica otro
    environment = "production"
    managed-by  = "terraform"
  }
}