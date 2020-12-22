resource "flexibleengine_cce_cluster_v3" "cce_cluster" {
  name                   = var.cluster_name
  cluster_type           = "VirtualMachine"
  cluster_version        = var.cluster_version
  flavor_id              = var.cluster_flavor
  vpc_id                 = var.vpc_id
  subnet_id              = var.network_id
  container_network_type = "overlay_l2"
  eip                    = var.cluster_eip
  description            = var.cluster_desc
}

locals {

  nodes_list_keys   = [for nodes in var.nodes_list : nodes.node_index]
  nodes_list_values = [for nodes in var.nodes_list : nodes]
  nodes_list_map    = zipmap(local.nodes_list_keys, local.nodes_list_values)

  node_pool_list_keys   = [for node_pool in var.node_pool_list : node_pool.node_pool_index]
  node_pool_list_values = [for node_pool in var.node_pool_list : node_pool]
  node_pool_list_map    = zipmap(local.node_pool_list_keys, local.node_pool_list_values)
}

resource "flexibleengine_cce_node_v3" "cce_cluster_node" {
  for_each = local.node_pool_list_map

  cluster_id        = flexibleengine_cce_cluster_v3.cce_cluster.id
  name              = each.value.node_name
  flavor_id         = each.value.node_flavor
  os                = var.node_os

  availability_zone = each.value.availability_zone
  key_pair          = var.key_pair

  postinstall       = each.value.postinstall_script
  preinstall        = each.value.preinstall_script

  labels = each.value.node_labels
  tags   = each.value.vm_tags

  root_volume {
    size       = each.value.root_volume_size
    volumetype = each.value.root_volume_type
  }

  data_volumes {
    size       = each.value.data_volume_size
    volumetype = each.value.data_volume_type
  }

  dynamic "taints" {
    for_each = each.value.taints
    content {
      key    = taints.value.key
      value  = taints.value.value
      effect = taints.value.effect
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [annotations, labels]
  }
}

# resource "flexibleengine_cce_node_v3" "cce_cluster_node" {
#   count             = length(var.nodes_list)
#   cluster_id        = flexibleengine_cce_cluster_v3.cce_cluster.id
#   name              = var.nodes_list[count.index]["node_name"]
#   flavor_id         = var.nodes_list[count.index]["node_flavor"]
#   os                = var.node_os
#   availability_zone = var.nodes_list[count.index]["availability_zone"]
#   key_pair          = var.key_pair
#   postinstall       = var.nodes_list[count.index]["postinstall_script"]
#   preinstall        = var.nodes_list[count.index]["preinstall_script"]

#   labels = var.nodes_list[count.index]["node_labels"]
#   tags   = var.nodes_list[count.index]["vm_tags"]

#   root_volume {
#     size       = var.nodes_list[count.index]["root_volume_size"]
#     volumetype = var.nodes_list[count.index]["root_volume_type"]
#   }

#   data_volumes {
#     size       = var.nodes_list[count.index]["data_volume_size"]
#     volumetype = var.nodes_list[count.index]["data_volume_type"]
#   }

#   dynamic "taints" {
#     for_each = var.nodes_list[count.index]["taints"]
#     content {
#       key    = taints.value.key
#       value  = taints.value.value
#       effect = taints.value.effect
#     }
#   }

#   lifecycle {
#     create_before_destroy = true
#     ignore_changes        = [annotations, labels]
#   }
# }



resource "flexibleengine_cce_node_pool_v3" "cce_node_pool" {
  for_each = local.node_pool_list_map

  cluster_id = flexibleengine_cce_cluster_v3.cce_cluster.id
  name       = each.value.node_pool_name
  os         = var.node_os

  flavor_id         = each.value.node_flavor
  availability_zone = each.value.availability_zone
  key_pair          = var.key_pair

  initial_node_count       = each.value.initial_node_count
  scall_enable             = each.value.scall_enable
  min_node_count           = each.value.min_node_count
  max_node_count           = each.value.max_node_count
  scale_down_cooldown_time = each.value.scale_down_cooldown_time
  priority                 = each.value.priority

  type = "vm"

  postinstall = each.value.postinstall_script
  preinstall  = each.value.preinstall_script

  labels = each.value.node_labels

  root_volume {
    size       = each.value.root_volume_size
    volumetype = each.value.root_volume_type
  }

  data_volumes {
    size       = each.value.data_volume_size
    volumetype = each.value.data_volume_type
  }

  dynamic "taints" {
    for_each = each.value.taints
    content {
      key    = taints.value.key
      value  = taints.value.value
      effect = taints.value.effect
    }
  }

}
