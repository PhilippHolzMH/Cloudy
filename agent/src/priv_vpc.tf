variable "region"{
  type = string
}
variable "ami"{
  type = string
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
}
  required_version = ">= 0.14.9"
}
provider "aws" {
  region = "${var.region}"
}
module "private-vpc" {
  source = "./module/private-vpc/"
}

module "key" {
  source = "./module/key/"  
}

