module "cce2_cluster" {
  source  = "FlexibleEngineCloud/cce/flexibleengine"
  version = "2.2.0"

  cluster_name      = "cluster-test"
  cluster_desc      = " Cluster for testing purpose"
  availability_zone = "eu-west-0a"

  cluster_flavor  = "cce.s1.small"
  vpc_id          = "<VPC_ID>"
  network_id      = "<NETWORK_ID>" //Caution here, you have to use NETWORK_ID even if argument is "subnet_id". Will be fixed soon
  cluster_version = "v1.15.6-r1"

  node_os  = "CentOS 7.5" // Can be "EulerOS 2.5" or "CentOS 7.5"
  key_pair = "<SSH_KEY_NAME>"

  nodes_list = [
    {
      node_name          = "new-node1"
      node_flavor        = "s3.large.2"
      availability_zone  = "eu-west-0a"
      root_volume_type   = "SATA"
      root_volume_size   = 40
      data_volume_type   = "SATA"
      data_volume_size   = 100
      node_labels        = null # this paramters si to be set empty for an existing node
      vm_tags            = null # this parameters can added to an existing node
      postinstall_script = data.template_file.test.rendered
      preinstall_script  = null
    }
  ]
}