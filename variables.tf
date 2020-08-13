# Required Parameters
variable "project_id" {
  description = "Google Cloud Platform Project Id"
  type        = string
}

# Optional Parameters
variable "name" {
  description = "Cluster Name"
  type        = string
  default     = "cluster"
}

variable "location" {
  description = "Region or zone for cluster. We'll use zone europe-west4-b"
  type        = string
  default     = "europe-west4-b"
}

variable "network_self_link" {
  description = "Network self link for project's network"
  type        = string
  default     = "default"
}

variable "subnetwork_self_link" {
  description = "Sub network self link for project's network"
  type        = string
  default     = "default"
}

variable "initial_node_count" {
  description = "Number of initial nodes to deploy"
  type        = number
  default     = 1
}

variable "node_pools" {
  description = "Map of node pools; all parameters within the config objects are required (min_node_count, max_node_count, image_type, machine_type, preemptible, labels, tags, auto_repair, auto_upgrade)"
  type = map(
    object({
      min_node_count    = number
      max_node_count    = number
      preemptible       = bool
      machine_type      = string
      image_type        = string
      labels            = map(string)
      tags              = set(string)
      auto_repair       = bool
      auto_upgrade      = bool
      max_pods_per_node = number
    })
  )

  default = {
    "pool-alfa" = {
      min_node_count    = 1
      max_node_count    = 2
      machine_type      = "n1-standard-1"
      preemptible       = false
      image_type        = "COS"
      labels            = {}
      tags              = []
      auto_repair       = true
      auto_upgrade      = true
      max_pods_per_node = 110
    }
  }
}

variable "gitops_enabled" {
  description = "Flag for GitOps option. If true, a namespace called 'gitops' will be created. Output will be 'gitops_namespace'"
  type        = bool
  default     = false
}