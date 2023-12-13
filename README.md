# Flexible Engine CCE2 Cluster Terraform Module

Terraform module for deploying a CCEv2 cluster.


## Module Version

- v2.3.0: **compatibility break!!** please read carefuly the release note https://github.com/FlexibleEngineCloud/terraform-flexibleengine-cce/releases/tag/v2.3.0
- v2.2.0: please read carefuly the release note https://github.com/FlexibleEngineCloud/terraform-flexibleengine-cce/releases/tag/v2.2.0
- v2.1.0: please read carefuly the release note https://github.com/FlexibleEngineCloud/terraform-flexibleengine-cce/releases/tag/v2.1.0

## Terraform format
```hcl
module "cce2_cluster" {
    source = "FlexibleEngineCloud/cce/flexibleengine"
    version = "2.3.0"
 
    cluster_name  = "cluster-test"
    cluster_desc = " Cluster for testing purpose"

    cluster_flavor = "cce.s1.small"
    vpc_id = "<VPC_ID>"
    network_id = "<NETWORK_ID>"  //Caution here, you have to use NETWORK_ID even if argument is "subnet_id". Will be fixed soon
    cluster_version = "v1.15.6-r1"

    node_os      = "CentOS 7.5" // Can be "EulerOS 2.5" or "CentOS 7.5"
    node_runtime = "containerd // Valid values are docker and containerd"
    key_pair     = "my-key"
 
    nodes_list = [
      {
        node_index         = "node0"
        node_name          = "cce-node1"
        node_flavor        = "s3.large.2"
        availability_zone  = "eu-west-0a"
        root_volume_type   = "SATA"
        root_volume_size   = 40
        data_volume_type   = "SATA"
        data_volume_size   = 100
        node_labels        = {}
        vm_tags            = {}
        postinstall_script =  null
        preinstall_script  = null
        taints             = []
      },
      {
        node_index        = "node1"
        node_name         = "cce-node2"
        node_flavor       = "s3.large.2"
        availability_zone = "eu-west-0b"
        root_volume_type  = "SATA"
        root_volume_size  = 40
        data_volume_type  = "SATA"
        data_volume_size  = 100
        node_labels = {
          type = "extra-node"
        }
        vm_tags = {
          Owner = "Me"
          Env = "Prod"
        }
        postinstall_script =  null
        preinstall_script  = null
        taints = [
          {
            key    = "key1"
            value  = "value1"
            effect = "NoSchedule"
          },
          {
            key    = "key1"
            value  = "value1"
            effect = "NoExecute"
          },
          {
            key    = "key2"
            value  = "value2"
            effect = "NoSchedule"
          }
        ]
      }
    ]

    node_pool_list = [
      {
        node_pool_index          = "nodepool0"
        node_pool_name           = "cce-nodepool-test"
        node_flavor              = "s3.large.2"
        availability_zone        = null
        initial_node_count       = 1
        scale_enable             = true
        min_node_count           = 1
        max_node_count           = 3
        scale_down_cooldown_time = null
        priority                 = null
        root_volume_type         = "SATA"
        root_volume_size         = 40
        data_volume_type         = "SATA"
        data_volume_size         = 100
        node_labels = {
          taints = "test-taint"
        }
        preinstall_script  = null
        postinstall_script = null
        taints = [
          {
            key    = "key1"
            value  = "value1"
            effect = "NoSchedule"
          },
          {
            key    = "key1"
            value  = "value1"
            effect = "NoExecute"
          },
          {
            key    = "key2"
            value  = "value2"
            effect = "NoSchedule"
          }
        ]
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
    source  = "FlexibleEngineCloud/cce/flexibleengine"
    version = "2.3.0"
}

include {
  path = find_in_parent_folders()
}

##################
### Parameters ###
##################

inputs = {
  cluster_name    = "cluster-test"
  cluster_desc    = "Cluster for testing purpose"
  cluster_flavor  = "cce.s1.small"
  cluster_version = "v1.15.6-r1"
  node_os         = "CentOS 7.5" // Can be "EulerOS 2.5" or "CentOS 7.5"
  node_runtime    = "containerd // Valid values are docker and containerd"
  key_pair        = "my-key"

  nodes_list = [
    {
      node_index         = "node0"
      node_name          = "existing-node-1"
      node_flavor        = "s3.xlarge.2"
      availability_zone  = "eu-west-0a"
      root_volume_type   = "SATA"
      root_volume_size   = 40
      data_volume_type   = "SATA"
      data_volume_size   = 100
      node_labels        = {}
      vm_tags            = {}
      postinstall_script =  null
      preinstall_script  = null
      tainst             = []
    },
    {
      node_index        = "node1"
      node_name         = "cce-node-2"
      node_flavor       = "s3.xlarge.2"
      availability_zone = "eu-west-0a" 
      root_volume_type  = "SATA"
      root_volume_size  = 40
      data_volume_type  = "SATA"
      data_volume_size  = 100
      node_labels = {
        type = "extra-node"
      }
      vm_tags = {
        Owner = "Me"
        Env = "Prod"
      }
      postinstall_script =  null
      preinstall_script  = null
      taints = [
        {
          key    = "key1"
          value  = "value1"
          effect = "NoSchedule"
        },
        {
          key    = "key1"
          value  = "value1"
          effect = "NoExecute"
        },
        {
          key    = "key2"
          value  = "value2"
          effect = "NoSchedule"
        }
      ]
    }
  ]

  node_pool_list = [
    {
      node_pool_index          = "nodepool0"
      node_pool_name           = "cce-nodepool-test"
      node_flavor              = "s3.large.2"
      availability_zone        = null
      initial_node_count       = 1
      scale_enable             = true
      min_node_count           = 1
      max_node_count           = 3
      scale_down_cooldown_time = null
      priority                 = null
      root_volume_type         = "SATA"
      root_volume_size         = 40
      data_volume_type         = "SATA"
      data_volume_size         = 100
      node_labels = {
        taints = "test-taint"
      }
      preinstall_script  = null
      postinstall_script = null
      taints = [
        {
          key    = "key1"
          value  = "value1"
          effect = "NoSchedule"
        },
        {
          key    = "key1"
          value  = "value1"
          effect = "NoExecute"
        },
        {
          key    = "key2"
          value  = "value2"
          effect = "NoSchedule"
        }
      ]
    }
  ]

}
```
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| flexibleengine | >= 1.17 |

## Providers

| Name | Version |
|------|---------|
| flexibleengine | >= 1.17 |

## Inputs

## Inputs

| Name                     | Description | Type | Default | Required |
|--------------------------|-------------|------|---------|:--------:|
| availability\_zone       | Availability Zone used to deploy | `string` | `"eu-west-0a"` | no |
| cluster\_desc            | Description of the cluster | `string` | n/a | yes |
| cluster\_eip             | EIP of the cluster | `string` | `null` | no |
| cluster\_flavor          | Flavor of the CCE2 Cluster | `string` | n/a | yes |
| cluster\_name            | Name of the cluster | `string` | n/a | yes |
| cluster\_type            | Cluster Type, possible values are VirtualMachine and BareMetal | `string` | VirtualMachine | no |
| cluster\_version         | Version of the cluster | `string` | n/a | yes |
| container\_network\_type | Network type of the container | `string` | `overlay_l2` | yes |
| extend\_param            | Extended Parameters | `map(string)` | `{}` | no |
| key\_pair                | Name of the SSH key pair | `string` | n/a | yes |
| network\_id              | ID of the Network | `string` | n/a | yes |
| node\_os                 | Operating System of the CCE Worker Node | `string` | n/a | yes |
| node\_pool\_list         | Nodes poool list of the CCE2 Cluster | <pre>list(object({<br>    node_pool_index          = string<br>    node_pool_name           = string<br>    node_flavor              = string<br>    availability_zone        = string<br>    initial_node_count       = number<br>    scale_enable             = bool<br>    min_node_count           = number<br>    max_node_count           = number<br>    scale_down_cooldown_time = number<br>    priority                 = number<br>    root_volume_size         = number<br>    root_volume_type         = string<br>   type			= string<br>	data_volume_size         = number<br>    data_volume_type         = string<br>    node_labels              = map(string)<br>    taints = list(object({<br>      key    = string<br>      value  = string<br>      effect = string<br>    }))<br>    postinstall_script = string<br>    preinstall_script  = string<br>  }))</pre> | `[]` | no |
| nodes\_list              | Nodes list of the CCE2 Cluster | <pre>list(object({<br>    node_index        = string<br>    node_name         = string<br>    node_flavor       = string<br>    availability_zone = string<br>    root_volume_size  = number<br>    root_volume_type  = string<br>    data_volume_size  = number<br>    data_volume_type  = string<br>    node_labels       = map(string)<br>    vm_tags           = map(string)<br>    taints = list(object({<br>      key    = string<br>      value  = string<br>      effect = string<br>    }))<br>    postinstall_script = string<br>    preinstall_script  = string<br>  }))</pre> | `[]` | no |
| vpc\_id                  | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | ID of the Cluster created |
| nodes\_ip | List of nodes IP adresses |
| nodes\_list | List of nodes |
| cce\_certificate\_clusters | Cluster certificate data and keys |
| cce\_certificate\_users | User certificate data and keys |
