variable "cluster_name" {
  description = "Name of the CCE cluster"
  default     = "cce-aan-0"
}

variable "cluster_type" {
  description = ""
  default     = "VirtualMachine"
}

variable "cluster_version" {
  description = ""
  default     = ""
}

variable "cluster_desc" {
  description = "Description of the cluster"
  default =""
}

variable "flavor_id" {
  description = ""
  default     = "cce.s1.small"
}

variable "vpc_id" {
  description = "ID of the VPC to use"
}

variable "subnet_id" {
  description = "WARNING: id of the used network"
}

variable "container_network_type" {
  description = "Container network parameters"
  default     = "overlay_l2"
}
