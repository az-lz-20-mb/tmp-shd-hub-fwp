# variable "resource_group_name" {
#   type = map(object({
#     rg = string
#     location = string
#   }))
# }

variable "firewall_policies" {
  type = map(object({
    name                = string
    resource_group_name = string
    location            = string
    intrusion_detection = optional(object({
      mode = optional(string, "Alert")
      signature_overrides = optional(map(string))
      traffic_bypass = optional(object({
        name                  = string
        protocol              = string
        destination_addresses = optional(list(string))
        destination_ip_groups = optional(list(string))
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
      }))
    }))
  }))
}