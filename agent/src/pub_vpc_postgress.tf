variable "db_engine"{
  type = string
}
variable "db_engine_version"{
  type = string
}
variable "instance_type"{
  type = string
}
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
variable "identifier"{
  type = string
}
variable "s3name" {
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
  instance_type       = "${var.instance_type}"
  db_engine           = "${var.db_engine}"
  db_engine_version   = "${var.db_engine_version}"
  identifier          = "${var.identifier}"
  db_password         = module.key.db_password
}

module "public-ec2" {
  source        = "./module/public-ec2/"
  public_subnet = module.public-vpc.public_subnet
  public_sg     = module.public-vpc.public_sg
  key           = module.key.key
  ami           = "${var.ami}"
  s3name        = "${var.s3name}"
}
module "key" {
  source = "./module/key/"  
}
