# Flexible Engine CCE Terraform Module

Terraform module which creates CCE: cluster and nodes

## Usage

```hcl
module "cce2_cluster" {
    source = "terraform-flexibleengine-modules/terraform-flexibleengine-cce"

    cluster_name = "cluster-test"
    #cluster_type = ""
    #cluster_flavor_id =""
    vpc_id = "<VPC_ID>"
    subnet_id= "<SUBNET_ID>"
    #container_network_type= ""
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| cluster\_name | Name of the cluster | string | `"terraform-test"` | yes |
| cluster\_flavor\_id | Flavor/Specifications (max. number of nodes, HA/non-HA,...) of the Cluster. [Possible values](https://www.terraform.io/docs/providers/flexibleengine/r/cce_cluster_v3.html#flavor_id "Flexible Engine Provider Argument Reference")| string | `"cce.s1.small"` | yes |
| cluster\_version | Version of the cluster (This value is changing regularly, please refer to API documentation. If not set, the latest version will be used) | string | n/a | no |
| cluster\_type | Type of the cluster. [Possible values](https://www.terraform.io/docs/providers/flexibleengine/r/cce_cluster_v3.html#cluster_type "Flexible Engine Provider Argument Reference") | string | `"VirtualMachine"` | yes |
| cluster\_desc | Description of the cluster | string | n/a | no |
| nodes\_list | List of nodes to deploy in the CCE2 Cluster | list | `<list>` | no |
| subnet\_id | WARNING: ID of the **Network** to use | string | n/a | yes |
| vpc\_id | ID of the VPC to use | string | n/a | yes |
| container\_network\_type | Container network parameters. [Possible values](https://www.terraform.io/docs/providers/flexibleengine/r/cce_cluster_v3.html#container_network_type "Flexible Engine Provider Argument Reference") | string | `"overlay_l2"` | yes |
| availability\_zone | Availability Zone used to deploy | string | `"eu-west-0a"` | no |


## Arguments exposed by the Provider but not used yet :

labels - (Optional) Cluster tag, key/value pair format. Changing this parameter will create a new cluster resource.

annotations - (Optional) Cluster annotation, key/value pair format. Changing this parameter will create a new cluster resource.

billing_mode - (Optional) Charging mode of the cluster, which is 0 (Currently, only payper-use is supported.). Changing this parameter will create a new cluster resource.

extend_param - (Optional) Extended parameter. Changing this parameter will create a new cluster resource.

highway_subnet_id - (Optional) The ID of the high speed network used to create bare metal nodes. Changing this parameter will create a new cluster resource.

container_network_cidr - (Optional) Container network segment. Changing this parameter will create a new cluster resource.

## Outputs

| Name | Description |
|------|-------------|
| cluster\_id | ID of the created CCE cluster  |
