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
#module "private-vpc"{
#  source = "./module/private-vpc/"
#}
#module "rds"{
#  source = "./module/database"
#  private_subnet = module.private-vpc.private_subnet
#  private_sg     = module.private-vpc.private_sg
#}
#memo an mich https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet_ids

module "public-ec2" {
  source        = "./module/public-ec2/"
  public_subnet = module.public-vpc.public_subnet
  public_sg     = module.public-vpc.public_sg
  key           = module.key.key
}
module "key" {
  source = "./module/key/"  
}

