terraform {
  required_providers {
    aws = {
    source  = "hashicorp/aws"
    }
  }
  required_version = ">= 0.14.9"
}
variable "hash_key" {
    type = string
}
variable "range_key" {
    type = string
}
module "public-vpc" {
  source = "./module/public-vpc/"
}
module "dynamodb"{
  source = "./module/dynamodb"
  hash_key = "${var.hash_key}"
  range_key = "${var.range_key}"
}

module "public-ec2" {
  source        = "./module/public-ec2/"
  public_subnet = module.public-vpc.public_subnet
  public_sg     = module.public-vpc.public_sg
  key           = module.key.key
}
module "key" {
  source = "./module/key/"  
}

