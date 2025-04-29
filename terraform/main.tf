module "vpc" {
  source = "./vpc"
  # VPC-specific input variables (if any)
}

module "instance" {
  source = "./intance"

  public1a_subnet_id = module.vpc.public1a_subnet_id
  public1b_subnet_id = module.vpc.public1b_subnet_id
  priv1a_subnet_id   = module.vpc.priv1a_subnet_id
  priv1b_subnet_id   = module.vpc.priv1b_subnet_id
  security_group     = module.vpc.security_group

  rds_endpoint= module.rds.rds_endpoint
}

module "rds" {
  source           = "./rds"
  priv2a_subnet_id = module.vpc.priv2a_subnet_id
  priv2b_subnet_id = module.vpc.priv2b_subnet_id
  security_group   = module.vpc.security_group
}

module "loadbalancer"{
  source = "./load_balancer"

  public1a_subnet_id = module.vpc.public1a_subnet_id
  public1b_subnet_id = module.vpc.public1b_subnet_id
  priv1a_subnet_id   = module.vpc.priv1a_subnet_id
  priv1b_subnet_id   = module.vpc.priv1b_subnet_id
  security_group   = module.vpc.security_group
  vpc_id = module.vpc.vpc_id
  rds_endpoint = module.rds.rds_endpoint
}