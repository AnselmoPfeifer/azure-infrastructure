locals {
  config = yamldecode(file("config/${terraform.workspace}.yml"))

  tags = {
    Environment = terraform.workspace
    Project     = local.config.project
    Workspace   = terraform.workspace
  }
}
