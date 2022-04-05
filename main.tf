terraform {
required_providers {
  aws = {
    source  = "hashicorp/aws"
  }
}
  required_version = ">= 0.14.9"
}
module "public-vpc" {
  source = "./module/public-vpc/"
}
module "rds"{
  source = "./module/database"
  private_subnet_list = module.public-vpc.private_subnet_list
  private_sg          = module.public-vpc.private_sg
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

