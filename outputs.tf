output "cluster_id" {
  description = "ID of the Cluster created"
  value       = flexibleengine_cce_cluster_v3.cce_cluster.id
}

output "nodes_list" {
  description = "List of nodes"
  value       = flexibleengine_cce_node_v3.cce_cluster_node.*
}

output "nodes_ip" {
  description = "List of IP nodes"
  value       = flexibleengine_cce_node_v3.cce_cluster_node.*.private_ip
}

