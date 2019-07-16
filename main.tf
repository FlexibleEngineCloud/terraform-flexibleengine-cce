terraform {
  required_version = ">= 0.10.3" # introduction of Local Values configuration language feature
}

resource "flexibleengine_cce_cluster_v3" "cce_cluster" {
	name = "${var.cluster_name}"
	cluster_type= "${var.cluster_type}"
  cluster_version = "${var.cluster_version}"
	flavor_id= "${var.cluster_flavor_id}"
	vpc_id= "${var.vpc_id}"
	subnet_id= "${var.subnet_id}"
	container_network_type= "${var.container_network_type}"
	description= "${var.cluster_desc}"
}
