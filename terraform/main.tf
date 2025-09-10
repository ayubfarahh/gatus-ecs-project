module "vpc" {
  source = "./modules/vpc"


}

module "alb" {
  source      = "./modules/alb"
  pub_subnets = module.vpc.pub_subnets
  vpc_id      = module.vpc.vpc_id

}

module "route53" {
  source = "./modules/route53"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
  
}

