data "terraform_remote_state" "network" {
  backend = "azurerm"
  config = {
    resource_group_name  = "devopresources"
    storage_account_name = "ascdevops"
    container_name       = "ascdevops"
    key                  = "apply/dev/backend/terraform-backend.tfstate"
  }
}


locals {
  vms = ["devops01", "devops02"]
  vms_config = {
    devops01 = {
      zone     = "1"
      subnetid = data.terraform_remote_state.network.outputs["subnetids"][0]
      publicip = data.terraform_remote_state.network.outputs["vmpublicip"][0]
      nicids   = data.terraform_remote_state.network.outputs["nicids"][0]
    },
    devops02 = {
      zone      = "2"
      subnet_id = data.terraform_remote_state.network.outputs["subnetids"][1]
      publicip  = data.terraform_remote_state.network.outputs["vmpublicip"][1]
      nicids    = data.terraform_remote_state.network.outputs["nicids"][1]
    }
  }
  lbpublicip = data.terraform_remote_state.network.outputs["lbpublicip"]
  vnetid     = data.terraform_remote_state.network.outputs["vnetid"]
}
