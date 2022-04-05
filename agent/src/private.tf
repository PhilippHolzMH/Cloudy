terraform {
required_providers {
  aws = {
    source  = "hashicorp/aws"
  }
}
  required_version = ">= 0.14.9"
}

module "private-vpc"{
  source = "./module/private-vpc/"
}