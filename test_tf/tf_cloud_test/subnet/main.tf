locals {
  region   = "ap-northeast-2"
  vpc_cidr = "66.88.144.0/22"
  tag      = "TEST"

  subnet_info = {
    bastion = [cidrsubnet(local.vpc_cidr, 3, 0), cidrsubnet(local.vpc_cidr, 3, 1)]
    nlb     = [cidrsubnet(local.vpc_cidr, 3, 2), cidrsubnet(local.vpc_cidr, 4, 7)]
    alb     = [cidrsubnet(local.vpc_cidr, 4, 8), cidrsubnet(local.vpc_cidr, 4, 9)]
    rds     = [cidrsubnet(local.vpc_cidr, 4, 10)]
  }

  route_info = {
    bastion = {
      dst_cidr = "0.0.0.0/0",
      dst_id   = module.vpc.igw_id
      rsc_type = "gw"
    },

    nlb = {
      dst_cidr = "0.0.0.0/0",
      dst_id   = module.nat.nat_id
      rsc_type = "nat"
    },

    alb = {
      dst_cidr = "0.0.0.0/0",
      dst_id   = module.nat.nat_id
      rsc_type = "nat"
    },
    rds = {
      dst_cidr = "0.0.0.0/0",
      dst_id   = module.nat.nat_id
      rsc_type = "nat"
    }
  }

  azs = ["${local.region}a", "${local.region}c"]
}

module "subnets" {
  source   = "github.com/devc4sh/terraformcloud"
  for_each = local.subnet_info

  vpc_id       = module.vpc.vpc_id
  tag          = local.tag
  azs          = local.azs
  subnet_cidrs = each.value
  subnet_name  = each.key

  depends_on = [
    module.vpc,
  ]
}

module "nat" {
  source    = "github.com/devc4sh/terraformcloud"
  subnet_id = module.subnets["bastion"].subnet_ids[0]
  tag       = local.tag

  depends_on = [
    module.subnets,
  ]
}

module "route" {
  source   = "github.com/devc4sh/terraformcloud"
  for_each = local.route_info

  rsc_cidr = each.value.dst_cidr
  rsc_type = each.value.rsc_type
  rsc_dst  = each.value.dst_id
  rt_id    = module.subnets[each.key].rt_id
}

output "subnets" {
  value = module.subnets
}