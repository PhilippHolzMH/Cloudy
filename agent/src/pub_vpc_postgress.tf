variable "ami"{
  type = string
}
variable "region"{
  type = string
}
variable "user_name" {
  type = string
}
variable "hd_size" {
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
module "public-vpc" {
  source = "./module/public-vpc/"
}
module "rds"{
  source = "./module/rds"
  private_subnet_ids  = module.public-vpc.private_subnet_ids
  private_sg          = module.public-vpc.private_sg
  user_name           = "${var.user_name}"
  hd_size             = "${var.hd_size}"
  db_password         = module.key.db_password
}

module "public-ec2" {
  source        = "./module/public-ec2/"
  public_subnet = module.public-vpc.public_subnet
  public_sg     = module.public-vpc.public_sg
  key           = module.key.key
  ami        = "${var.ami}"
}
module "key" {
  source = "./module/key/"  
}
