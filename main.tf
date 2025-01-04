module "vpc_a" {
  source               = "./vpc"
  
  providers = {
    aws = aws.us_west_1
  }

  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  name                 = "vpc-a"

  public_subnets       = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets      = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones   = ["us-west-1a", "us-west-1b"]

}

module "vpc_b" {
  source               = "./vpc"
  providers = {
    aws = aws.us_west_2
  }

  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  name                 = "vpc-b"

  public_subnets       = ["10.1.1.0/24", "10.1.2.0/24"]
  private_subnets      = ["10.1.3.0/24", "10.1.4.0/24"]
  availability_zones   = ["us-west-2a", "us-west-2b"]
  
}

module "vpc_c" {
  source               = "./vpc"
  providers = {
    aws = aws.us_east_1
  }
  cidr_block           = "10.2.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  name                 = "vpc-c"

  public_subnets       = ["10.2.1.0/24", "10.2.2.0/24"] 
  private_subnets      = ["10.2.3.0/24", "10.2.4.0/24"]
  availability_zones   = ["us-east-1a", "us-east-1b"]
}

module "peering_vpc_b_to_vpc_a" {
  source            = "./vpc_peering"
  requester_vpc_id  = module.vpc_b.vpc_id
  accepter_vpc_id   = module.vpc_a.vpc_id
  accepter_region   = "us-west-1"
  name              = "vpc-b-to-vpc-a"
  providers = {
    aws = aws.us_west_2
  }

  private_route_table_id = module.vpc_b.private_route_table_id
  cidr_block = module.vpc_a.cidr_block

}
module "peering_accepter_vpc_b_to_vpc_a"{
    source          = "./vpc_peering_accepter"
    peering_connection_id = module.peering_vpc_b_to_vpc_a.peering_connection_id
    providers = {
    aws = aws.us_west_1
  }
}


module "peering_vpc_b_to_vpc_c" {
  source            = "./vpc_peering"
  requester_vpc_id  = module.vpc_b.vpc_id
  accepter_vpc_id   = module.vpc_c.vpc_id
  accepter_region   = "us-east-1"
  name              = "vpc-b-to-vpc-c"
  providers = {
    aws = aws.us_west_2
  }

  private_route_table_id = module.vpc_b.private_route_table_id
  cidr_block = module.vpc_c.cidr_block
}

module "peering_accepter_vpc_b_to_vpc_c"{
    source          = "./vpc_peering_accepter"
    peering_connection_id = module.peering_vpc_b_to_vpc_c.peering_connection_id
    providers = {
    aws = aws.us_east_1
  }
}
module "ec2_instance_vpc_a" {
  name = "client"
  source          = "./ec2_instance"
  vpc_id = module.vpc_a.vpc_id
  instance_type = "t2.micro"
  subnet_ids = [
    module.vpc_a.private_subnet_ids[0],
    module.vpc_a.public_subnet_ids[0]
  ]
  key_name = "key-for-3-vpcs"
  region           = "us-west-1"

  providers = {
      aws = aws.us_west_1
    }
}

module "ec2_instance_vpc_b" {
  name = "jump"
  source          = "./ec2_instance"
  vpc_id = module.vpc_b.vpc_id
  instance_type = "t2.micro"
  subnet_ids = [
    module.vpc_b.public_subnet_ids[0]
  ]
  key_name = "b-vpc-key"
  region           = "us-west-2"

  providers = {
      aws = aws.us_west_2
    }
}

module "ec2_instance_vpc_c" {
  name = "server"
  source          = "./ec2_instance"
  vpc_id = module.vpc_c.vpc_id
  instance_type = "t2.micro"
  subnet_ids    = [
    module.vpc_c.private_subnet_ids[0]
  ]
  key_name = "c-vpc-key"
  region           = "us-east-1"
  
  providers = {
      aws = aws.us_east_1
    }
}