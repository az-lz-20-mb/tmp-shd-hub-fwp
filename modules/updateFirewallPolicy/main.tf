# modules/firewall_policy/main.tf
resource "azurerm_firewall_policy" "this" {
  for_each = var.firewall_policies

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  dynamic "intrusion_detection" {
    for_each = try(each.value.intrusion_detection, null) != null ? [each.value.intrusion_detection] : []

    content {
      mode = intrusion_detection.value.mode

      dynamic "signature_override" {  # Correct attribute name (singular)
        for_each = try(intrusion_detection.value.signature_overrides, {})

        content {
          id    = signature_override.key
          state = signature_override.value
        }
      }

      dynamic "traffic_bypass" {
        for_each = try(intrusion_detection.value.traffic_bypass, {})

        content {
          name                  = traffic_bypass.value.name
          protocol              = traffic_bypass.value.protocol
          destination_addresses = try(traffic_bypass.value.destination_addresses, null)
          destination_ip_groups = try(traffic_bypass.value.destination_ip_groups, null)
          source_addresses      = try(traffic_bypass.value.source_addresses, null)
          source_ip_groups      = try(traffic_bypass.value.source_ip_groups, null)
        }
      }
    }
  }
}

output "firewall_policy" {
  value = azurerm_firewall_policy.this
}