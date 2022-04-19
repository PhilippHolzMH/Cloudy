variable "region"{
  type = string
}
variable "ami"{
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

module "public-ec2" {
  source        = "./module/public-ec2/"
  public_subnet = module.public-vpc.public_subnet
  public_sg     = module.public-vpc.public_sg
  key           = module.key.key
  ami           = "${var.ami}"
  s3name        = "${var.s3name}"
}
module "target-group" {
  source        ="./module/target-group/"
  vpcid         = module.public-vpc.vpcid
  cidrblock     = module.public-vpc.cidrblock
}
module "loadbalancer" {
  source = "./module/loadbalancer"
  public_subnet = module.public-vpc.public_subnet
  public_sg     = module.public-vpc.public_sg 
  instanceid    = module.public-ec2.ec2id 
  elb_tg_arn    = module.target-group.elb_tg_arn
}
module "key" {
  source = "./module/key/"  
}

