source "azure-arm" "windows" {
  client_id       = "{{env `AZURE_CLIENT_ID`}}"
  client_secret   = "{{env `AZURE_CLIENT_SECRET`}}"
  subscription_id = "{{env `AZURE_SUBSCRIPTION_ID`}}"
  tenant_id       = "{{env `AZURE_TENANT_ID`}}"

  resource_group_name = "{{env `RESOURCE_GROUP`}}"
  location            = "East US"
  vm_size             = "Standard_D2s_v3"

  managed_image_name   = "WindowsCustomImage"
  managed_image_resource_group_name = "{{env `RESOURCE_GROUP`}}"
  os_type              = "Windows"
  image_publisher      = "MicrosoftWindowsServer"
  image_offer          = "WindowsServer"
  image_sku            = "2019-Datacenter"
  image_version        = "latest"
}

build {
  sources = ["source.azure-arm.windows"]

  provisioner "powershell" {
    inline = [
      "Install-WindowsFeature -name Web-Server",
      # Add additional custom configurations here
    ]
  }
}