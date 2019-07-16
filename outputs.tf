output "cluster_id" {
  description = "ID of the Cluster created"
  value       = "${flexibleengine_cce_cluster_v3.cce_cluster.id}"
} 
