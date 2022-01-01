locals {
  region   = "ap-northeast-2"
  vpc_cidr = "66.88.144.0/22"
  tag      = "TEST"
}

module "vpc" {
  source     = "github.com/devc4sh/terraformcloud/test_tf/tf_cloud_test/modules/vpc"
  vpc_cidr   = local.vpc_cidr
  enable_igw = true
  tag        = local.tag
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "igw_id" {
  value = module.vpc.igw_id
}