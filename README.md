# Flexible Engine CCE2 Cluster Terraform Module

Terraform module for deploying a CCEv2 cluster.

## TF version : 0.13

## Terraform format
```hcl
module "cce2_cluster" {
  source = "github.com/terraform-flexibleengine-modules/terraform-flexibleengine-cce?ref=v1.0.0"

    cluster_name  = "cluster-test"
    cluster_desc = " Cluster for testing purpose"
    availability_zone = "eu-west-0a"

    cluster_flavor = "cce.s1.small"
    vpc_id = "<VPC_ID>"
    network_id = "<NETWORK_ID>"  //Caution here, you have to use NETWORK_ID even if argument is "subnet_id". Will be fixed soon
    cluster_version = "v1.13.10-r0"

    node_os = "EulerOS 2.5" // Can be "EulerOS 2.5" or "CentOS 7.6"
 
    nodes_list = [
      {
        node_name = "test-node1"
        node_flavor = "s3.large.2"
        availability_zone = "eu-west-0a"
        key_pair = "my-key"
        root_volume_type = "SATA"
        root_volume_size = 40
        data_volume_type = "SATA"
        data_volume_size = 100
      },
      {
        node_name = "test-node2"
        node_flavor = "s3.large.2"
        availability_zone = "eu-west-0a"
        key_pair = "my-key"
        root_volume_type = "SATA"
        root_volume_size = 40
        data_volume_type = "SATA"
        data_volume_size = 100
      }
    ]
}
```

## Terragrunt format
```hcl
################################
### Terragrunt Configuration ###
################################

terraform {
  source = "git::git@github.com:terraform-flexibleengine-modules/terraform-flexibleengine-cce.git?ref=v1.0.0"
}

include {
  path = find_in_parent_folders()
}

##################
### Parameters ###
##################

inputs = {
  cluster_name  = "cce-xxx"
  cluster_desc = "CCEv2 Cluster xxx"
  cluster_flavor = "cce.s1.small"
  cluster_version = "v1.13.10-r0"
  node_os = "EulerOS 2.5" // Can be "EulerOS 2.5" or "CentOS 7.6"

  nodes_list = [
    {
      node_name = "cce-xxx-1"
      node_flavor = "s3.xlarge.2"
      availability_zone = "eu-west-0a"
      key_pair = "xxx-key"
      root_volume_type = "SATA"
      root_volume_size = 40
      data_volume_type = "SATA"
      data_volume_size = 100
    },
    {
      node_name = "cce-xxx-2"
      node_flavor = "s3.xlarge.2"
      availability_zone = "eu-west-0a"
      key_pair = "xxx-key"
      root_volume_type = "SATA"
      root_volume_size = 40
      data_volume_type = "SATA"
      data_volume_size = 100
      labels = {
        type = "xxx"
      }
      annotations = {}
    },
    {
      node_name = "cce-xxx-3"
      node_flavor = "s3.xlarge.2"
      availability_zone = "eu-west-0a"
      key_pair = "xxx-key"
      root_volume_type = "SATA"
      root_volume_size = 40
      data_volume_type = "SATA"
      data_volume_size = 100
    }
  ]
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| availability\_zone | Availability Zone used to deploy | string | `"eu-west-0a"` | no |
| cluster\_desc | Description of the cluster | string | n/a | yes |
| cluster\_flavor | Flavor of the CCE2 Cluster to deploy | string | n/a | yes |
| cluster\_name | Name of the cluster | string | n/a | yes |
| node\_os | Operating System of the CCE Worker Node | n/a | n/a | yes |
| nodes\_list | List of nodes to deploy in the CCE2 Cluster | list(object(node_name(string), node_flavor(string), key_pair(string), availability_zone(string), root_volume_size(number), root_volume_type(string), data_volume_size(number), data_volume_type)) | `<list>` | no |
| network\_id | ID of the network to use | string | n/a | yes |
| vpc\_id | ID of the VPC to use | string | n/a | yes |

## Outputs

| Name | Description | Type |
|------|-------------|------|
| cluster\_id | ID of the Cluster created | string
| nodes\_list | List of nodes created | list(object)
| nodes\_ip | IP List of Nodes | list(string)
