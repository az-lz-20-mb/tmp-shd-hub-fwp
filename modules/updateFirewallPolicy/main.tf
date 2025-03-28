module "firewall_policy" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-firewallpolicy.git"
  for_each = var.firewall_policy_names  # Expecting a map of policy names

  name                = each.value.name  # Use the name from the map
  location            = lookup(var.resource_group_name[each.value.location], "location") 
  resource_group_name = lookup(var.resource_group_name[each.value.location], "rg") 

  # Attach TLS Inspection - conditionally based on variable
  # tls_inspection {
  #   key_vault_secret_id = each.value.tls_inspection_key_vault_secret_id
  # }

  # Enable Intrusion Detection (IDPS)
  intrusion_detection {
    mode = each.value.intrusion_detection_mode  # Use mode from the map

    traffic_bypass = each.value.intrusion_detection_traffic_bypass # Use bypass rules from the map
  }
}