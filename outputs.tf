output "cluster_id" {
  description = "ID of the Cluster created"
  value       = flexibleengine_cce_cluster_v3.cce_cluster.id
}

output "nodes_list" {
  description = "List of nodes"
  # value       = flexibleengine_cce_node_v3.cce_cluster_node.*
  value       = [for node in flexibleengine_cce_node_v3.cce_cluster_node : node]
}

output "nodes_ip" {
  description = "List of nodes IP"
  value       = [for node in flexibleengine_cce_node_v3.cce_cluster_node : node.private_ip]
}

