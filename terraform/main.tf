module "vpc" {
  source = "./modules/vpc"


}

module "alb" {
  source      = "./modules/alb"
  pub_subnets = module.vpc.pub_subnets
  vpc_id      = module.vpc.vpc_id

}