variable "resource_group_name" {
  type = map(object({
    rg = string
    location = string
  }))
}

variable "firewall_policy_names" {
  type = map(object({
    name = string
    location = string
    # tls_inspection_key_vault_secret_id = string
    intrusion_detection_mode = string
    intrusion_detection_traffic_bypass = list(object({
      name = string
      protocol = string
    }))
  }))
  description = "A map of firewall policy definitions."
}