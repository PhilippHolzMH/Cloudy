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
module "dynamodb"{
  source = "./module/dynamodb"

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
