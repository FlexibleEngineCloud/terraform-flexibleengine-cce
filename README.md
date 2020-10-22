# Flexible Engine CCE2 Cluster Terraform Module

Terraform module for deploying a CCEv2 cluster.

## TF version : 0.13


## Module Version

> **Important Notes regarding new module version (as of v2.1.0)**

> **Note #1**
>
> Two additionnal parameters:
> - vm_tags: Tag at Flexible Engine level
> - node_label: Kubernetes Node Label (to apply a Pod placement constraint with the NodeSelector setting in Kubernetes manifest for instance)
>
> These two parameters are mandatory but can be empty with this module
>
> Please add these two parameters to each of the node in the node_list parameters as shown bellow.
>
>  Add vm_tags does not recreate the node
>
> Add node_labels recreate the node so even if the current nodes does not have any lables, please do not forget to add node_labels set it empty like the bellow example.

> **Note #2**
>
>  CCE Node SSH Key pair is now a global parameter (was a specific node configuratin parameter before)
>
> Please comment out the key_pair parameters of the existing nodes and declare key_pair parameter as a global as shown in the examples bellow.

## Terraform format
```hcl
module "cce2_cluster" {
    source = "FlexibleEngineCloud/elb/flexibleengine"
 
    cluster_name  = "cluster-test"
    cluster_desc = " Cluster for testing purpose"
    availability_zone = "eu-west-0a"

    cluster_flavor = "cce.s1.small"
    vpc_id = "<VPC_ID>"
    network_id = "<NETWORK_ID>"  //Caution here, you have to use NETWORK_ID even if argument is "subnet_id". Will be fixed soon
    cluster_version = "v1.15.6-r1"

    node_os  = "CentOS 7.5" // Can be "EulerOS 2.5" or "CentOS 7.5"
    key_pair = "my-key"
 
    nodes_list = [
      {
        node_name = "existing-node1"
        node_flavor = "s3.large.2"
        availability_zone = "eu-west-0a"
        # key_pair = "my-key" # Key pair paramters moved to global parameter
        root_volume_type = "SATA"
        root_volume_size = 40
        data_volume_type = "SATA"
        data_volume_size = 100
        node_labels       = {} # this paramters si to be set empty for an existing node
        vm_tags           = {} # this parameters can added to an existing node
      },
      {
        node_name = "new-node2"
        node_flavor = "s3.large.2"
        availability_zone = "eu-west-0b"
        root_volume_type = "SATA"
        root_volume_size = 40
        data_volume_type = "SATA"
        data_volume_size = 100
        node_labels       = {
          type = "extra-node"
        }
        vm_tags           = {
          Owner = "Me"
          Env = "Prod"
        }
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
  cluster_name  = "cluster-test"
  cluster_desc = "Cluster for testing purpose"
  cluster_flavor = "cce.s1.small"
  cluster_version = "v1.15.6-r1"
  node_os  = "CentOS 7.5" // Can be "EulerOS 2.5" or "CentOS 7.5"
  key_pair = "my-key"

  nodes_list = [
    {
      node_name = "existing-node-1"
      node_flavor = "s3.xlarge.2"
      availability_zone = "eu-west-0a"
      # key_pair = "my-key" # Key pair paramters moved to global parameter
      root_volume_type = "SATA"
      root_volume_size = 40
      data_volume_type = "SATA"
      data_volume_size = 100
      node_labels       = {} # this paramters si to be set empty for an existing node
      vm_tags           = {} # this parameters can added to an existing node
    },
    {
      node_name = "new-node-2"
      node_flavor = "s3.xlarge.2"
      availability_zone = "eu-west-0a" 
      root_volume_type = "SATA"
      root_volume_size = 40
      data_volume_type = "SATA"
      data_volume_size = 100
      node_labels       = {
        type = "extra-node"
      }
      vm_tags           = {
        Owner = "Me"
        Env = "Prod"
      }
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| flexibleengine | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_zone | Availability Zone used to deploy | `string` | `"eu-west-0a"` | no |
| cluster\_desc | Description of the cluster | `string` | n/a | yes |
| cluster\_flavor | Flavor of the CCE2 Cluster | `string` | n/a | yes |
| cluster\_name | Name of the cluster | `string` | n/a | yes |
| cluster\_version | Version of the cluster | `string` | n/a | yes |
| key\_pair | Name of the SSH key pair | `string` | n/a | yes |
| network\_id | ID of the Network | `string` | n/a | yes |
| node\_os | Operating System of the CCE Worker Node | `string` | n/a | yes |
| nodes\_list | Nodes list of the CCE2 Cluster | <pre>list(object({<br>    node_name         = string<br>    node_flavor       = string<br>    availability_zone = string<br>    root_volume_size  = number<br>    root_volume_type  = string<br>    data_volume_size  = number<br>    data_volume_type  = string<br>    node_labels       = map(string)<br>    vm_tags           = map(string)<br>  }))</pre> | `[]` | no |
| vpc\_id | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | ID of the Cluster created |
| nodes\_ip | List of IP nodes |
| nodes\_list | List of nodes |
