locals {
  subnet_names = ["sbndevops1", "sbndevops2"]
  subnet_config = {
    sbndevops1 = {
      address_prefixes = "10.0.1.0/24"
    },
    sbndevops2 = {
      address_prefixes = "10.0.2.0/24"
    }
  }

  ports = [
    {
      port     = "22"
      priority = 100
    },
    {
      port     = "80"
      priority = 101
    },
    {
      port     = "443"
      priority = 102
    },
  ]

  vms = ["devops01", "devops02"]
  vms_config = {
    devops01 = {
      publicIpName = "ipdevops01"
    },
    devops02 = {
      publicIpName = "ipdevops02"
    },
  }
}
