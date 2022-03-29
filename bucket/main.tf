provider "aws" {
  region = "eu-west-1"
}

locals {
  name   = "complete-example"
  region = "eu-west-1"
  tags = {
    Owner       = "user"
    Environment = "staging"
    Name        = "complete"
  }
}

module "vpc" {
  source = "../../"

  name = local.name
  cidr = "20.10.0.0/16" # 10.0.0.0/8 is reserved for EC2-Classic

  azs                 = ["${local.region}a", "${local.region}b", "${local.region}c"]
  private_subnets     = ["20.10.1.0/24", "20.10.2.0/24", "20.10.3.0/24"]
  public_subnets      = ["20.10.11.0/24", "20.10.12.0/24", "20.10.13.0/24"]
  database_subnets    = ["20.10.21.0/24", "20.10.22.0/24", "20.10.23.0/24"]
  elasticache_subnets = ["20.10.31.0/24", "20.10.32.0/24", "20.10.33.0/24"]
  redshift_subnets    = ["20.10.41.0/24", "20.10.42.0/24", "20.10.43.0/24"]
  intra_subnets       = ["20.10.51.0/24", "20.10.52.0/24", "20.10.53.0/24"]

  create_database_subnet_group = false

  manage_default_network_acl = true
  default_network_acl_tags   = { Name = "${local.name}-default" }

  manage_default_route_table = true
  default_route_table_tags   = { Name = "${local.name}-default" }

  manage_default_security_group = true
  default_security_group_tags   = { Name = "${local.name}-default" }

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_classiclink             = true
  enable_classiclink_dns_support = true

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_vpn_gateway = true

  enable_dhcp_options              = true
  dhcp_options_domain_name         = "service.consul"
  dhcp_options_domain_name_servers = ["127.0.0.1", "10.10.0.2"]

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = true
  create_flow_log_cloudwatch_log_group = true
  #create_flow_log_cloudwatch_iam_role  = true
  flow_log_max_aggregation_interval    = 60

  tags = local.tags
}


################################################################################
# Supporting Resources
################################################################################

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}


resource "aws_security_group" "vpc_tls" {
  name_prefix = "${local.name}-vpc_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [module.vpc.vpc_cidr_block]
  }

  tags = local.tags
}

