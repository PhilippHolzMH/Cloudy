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
  source = "./module/rds"
  private_subnet_ids  = module.public-vpc.private_subnet_ids
  private_sg          = module.public-vpc.private_sg
  db_name             = module.key.db_name
  db_password         = module.key.db_password
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
