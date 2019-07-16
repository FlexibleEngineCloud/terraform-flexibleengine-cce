output "cluster_id" {
  description = "ID of the created CCE cluster"
  value       = "${flexibleengine_cce_cluster_v3.cce_cluster.id}"
}
