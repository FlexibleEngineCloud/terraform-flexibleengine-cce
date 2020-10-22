resource "flexibleengine_cce_cluster_v3" "cce_cluster" {
  name                   = var.cluster_name
  cluster_type           = "VirtualMachine"
  cluster_version        = var.cluster_version
  flavor_id              = var.cluster_flavor
  vpc_id                 = var.vpc_id
  subnet_id              = var.network_id
  container_network_type = "overlay_l2"
  description            = var.cluster_desc
}

resource "flexibleengine_cce_node_v3" "cce_cluster_node" {
  count             = length(var.nodes_list)
  cluster_id        = flexibleengine_cce_cluster_v3.cce_cluster.id
  name              = var.nodes_list[count.index]["node_name"]
  flavor_id         = var.nodes_list[count.index]["node_flavor"]
  os                = var.node_os
  availability_zone = var.nodes_list[count.index]["availability_zone"]
  key_pair          = var.key_pair

  labels = var.nodes_list[count.index]["node_labels"]
  tags   = var.nodes_list[count.index]["vm_tags"]

  root_volume {
    size       = var.nodes_list[count.index]["root_volume_size"]
    volumetype = var.nodes_list[count.index]["root_volume_type"]
  }

  data_volumes {
    size       = var.nodes_list[count.index]["data_volume_size"]
    volumetype = var.nodes_list[count.index]["data_volume_type"]
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [annotations, labels]
  }
}

