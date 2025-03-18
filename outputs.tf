output "resource_group" {
  value = {
    Name     = module.resource_group.name
    Location = module.resource_group.location
  }
}

output "virtual_network" {
  value = {
    Name         = module.virtual_network.name
    Location     = module.virtual_network.location
    AddressSpace = module.virtual_network.address_space
    Subnets      = module.virtual_network.subnets
  }
}
