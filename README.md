# Azure Infrastructure as Code

This project contains Terraform configurations for managing Azure infrastructure, with a focus on networking components and security features.

## First Setup

Before deploying the main infrastructure, you need to set up remote state storage in Azure. This setup is crucial for the following reasons:

- **Team Collaboration**: Remote state enables multiple team members to safely work with the same infrastructure
- **Security**: Azure Storage provides encryption at rest for sensitive state data
- **State Persistence**: Prevents accidental state file deletion that could occur with local storage
- **State Locking**: Prevents concurrent state operations that could corrupt the infrastructure state

The `first-setup` folder contains Terraform configurations that will:

1. Create an Azure Resource Group for state storage
2. Create an Azure Storage Account with encryption enabled
3. Create a Storage Container to store the Terraform state files
4. Configure state locking to prevent concurrent modifications

## Features

### Resource Group Module

- **Automated Resource Group Management**: Creates and manages Azure resource groups
- **Location Flexibility**: Deploy resources in any Azure region
- **Tag Support**: Comprehensive tagging system for resource organization and cost tracking

### Virtual Network Module

- **Dynamic Virtual Network Creation**: Configurable address spaces and multiple subnets
- **Enhanced Security Features**:
  - DDoS Protection Plan (optional) - Can be enabled/disabled per virtual network
  - Network Encryption with configurable enforcement policies:
    - `AllowUnencrypted`
    - `DropUnencrypted`
    - `None`
  - Customizable DNS servers

## Usage

### Basic Virtual Network

```hcl
module "vnet" {
  source              = "https://github.com/org/terraform-modules/azure/vnet"
  name                = "my-vnet"
  location            = "eastus"
  resource_group_name = "my-resource-group"
  address_space       = ["10.0.0.0/16"]

  subnets = [
    {
      name             = "subnet1"
      address_prefixes = ["10.0.1.0/24"]
    }
  ]
}
```

### With DDoS Protection

```hcl
module "vnet" {
  source              = "https://github.com/org/terraform-modules/azure/vnet"
  name                = "my-vnet"
  location            = "eastus"
  resource_group_name = "my-resource-group"
  address_space       = ["10.0.0.0/16"]

  ddos_protection_plan = {
    enable = true
  }
}
```

### With Network Encryption

```hcl
module "vnet" {
  source                 = "https://github.com/org/terraform-modules/azure/vnet"
  name                   = "my-vnet"
  location               = "eastus"
  resource_group_name    = "my-resource-group"
  address_space         = ["10.0.0.0/16"]
  encryption_enforcement = "DropUnencrypted"
}
```

## Prerequisites

- Terraform >= 1.0
- Azure CLI
- Azure Subscription
- Proper Azure credentials configured

## Best Practices

- Store sensitive information like subscription IDs in environment variables
- Use terraform.tfvars for environment-specific variables (don't commit to version control)
- Review network security group rules before applying changes
- Enable DDoS protection for production environments
