variable "project" { }

variable "credentials_file" { }

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-c"
}

variable "machine_types" {
  type = map(string)
  default = {
    "dev" = "f1-micro"
    "test" = "g1-small"
    "prod" = "n1-standard-1"
  }
}

variable "cidrs" { 
   type = list 
}
