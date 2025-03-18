module "resource_group" {
  source = "git@github.com:AnselmoPfeifer/terraform-modules.git//azure/rg?ref=main"

  resource_group_name     = "rg-${local.config.project}-${local.config.environment}"
  resource_group_location = local.config.region
  resource_group_tags     = local.tags
}

module "virtual_network" {
  source     = "git@github.com:AnselmoPfeifer/terraform-modules.git//azure/vnet?ref=main"
  depends_on = [module.resource_group]

  resource_group_name = module.resource_group.name
  environment         = local.config.environment
  location            = local.config.region
  name                = "vnet-${local.config.project}-${local.config.environment}"
  address_space       = local.config.vnet.address_space

  encryption_enforcement = "AllowUnencrypted"
  ddos_protection_plan = {
    enable = true
  }

  subnets = local.config.vnet.subnets
  tags    = local.tags
}
