variable "region" {
  type = string
}
variable "ami" {
  type = string
}
variable "s3name" {
  type = string
}
variable "desired_capacity" {
  type = number  
}
variable "max_size"{
  type = number
}
variable "min_size"{
  type = number
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
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
  source    = "./module/target-group/"
  vpcid     = module.public-vpc.vpcid
  cidrblock = module.public-vpc.cidrblock
}
module "loadbalancer" {
  source      = "./module/loadbalancer/"
  public_sub1 = module.public-vpc.public_subnet_for_lb1
  public_sub2 = module.public-vpc.public_subnet_for_lb2
  public_sg   = module.public-vpc.public_sg
  instanceid  = module.public-ec2.ec2id
  lb_tg_arn   = module.target-group.lb_tg_arn
}
module "ami-lc"{
  source        = "./module/ami-lc/"
  instanceid    = module.public-ec2.ec2id 
  key           = module.key.key
  public_sg     = module.public-vpc.public_sg
  public_subnet = module.public-vpc.public_subnet
}
module "autoscale"{
  source            = "./module/autoscale/"
  template_id       = module.ami-lc.template_id
  public_sub1       = module.public-vpc.public_subnet_for_lb1
  public_sub2       = module.public-vpc.public_subnet_for_lb2
  desired_capacity  = "${var.desired_capacity}"
  max_size          = "${var.max_size}"
  min_size          = "${var.min_size}"
}

module "key" {
  source = "./module/key/"
}

