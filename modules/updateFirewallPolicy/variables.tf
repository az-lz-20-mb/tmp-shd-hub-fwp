variable "location" {
  type        = string
  description = "The Azure region to deploy resources into."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "firewall_policy_names" {
  type = map(object({
    name = string
    tls_inspection_key_vault_secret_id = string
    intrusion_detection_mode = string
    intrusion_detection_traffic_bypass = list(object({
      name = string
      protocol = string
    }))
  }))
  description = "A map of firewall policy definitions."
}