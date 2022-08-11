output "cluster_id" {
  description = "ID of the Cluster created"
  value       = flexibleengine_cce_cluster_v3.cce_cluster.id
}

output "nodes_list" {
  description = "List of nodes"
  value       = [for node in flexibleengine_cce_node_v3.cce_cluster_node : node]
}

output "nodes_ip" {
  description = "List of nodes IP addresses"
  value       = [for node in flexibleengine_cce_node_v3.cce_cluster_node : node.private_ip]
}

output "cce_certificate_clusters" {
  value       = flexibleengine_cce_cluster_v3.cce_cluster.certificate_clusters
  description = "CCE cluster certificate"
}
output "cce_certificate_users" {
  value       = flexibleengine_cce_cluster_v3.cce_cluster.certificate_users
  description = "CCE user certificate"
}
