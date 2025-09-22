module "vpc" {
  source = "./modules/vpc"


}

module "ecs" {
  source = "./modules/ecs"
  alb_tg_arn = module.alb.alb_tg_arn
  priv_subnets = module.vpc.priv_subnets
  vpc_id = module.vpc.vpc_id
  alb_sg = module.alb.alb_sg
  
}

module "alb" {
  source      = "./modules/alb"
  pub_subnets = module.vpc.pub_subnets
  vpc_id      = module.vpc.vpc_id
  acm_arn = module.acm.acm_arn

}

module "route53" {
  source = "./modules/route53"
  alb_dns_name = module.alb.alb_dns_name
  alb_zone_id = module.alb.alb_zone_id
  
}

module "acm" {
  source = "./modules/acm"
  zone_id = module.route53.zone_id
  
}

