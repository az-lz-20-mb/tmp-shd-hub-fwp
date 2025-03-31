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
      mode           = optional(string)
      private_ranges = optional(list(string))
      signature_overrides = optional(list(object({
        id    = optional(string)
        state = optional(string)
      })))
      traffic_bypass = optional(list(object({
        description           = optional(string)
        destination_addresses = optional(set(string))
        destination_ip_groups = optional(set(string))
        destination_ports     = optional(set(string))
        name                  = string
        protocol              = string
        source_addresses      = optional(set(string))
        source_ip_groups      = optional(set(string))
      })))
    }))
  }))
  default = {}
}