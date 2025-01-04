# Terraform Multi-VPC and EC2 Setup

This Terraform configuration sets up three Virtual Private Clouds (VPCs) in different AWS regions, establishes VPC peering connections between them, and provisions EC2 instances within each VPC.

# How to Use

Clone this repository and navigate to the Terraform directory.

Initialize Terraform:

``` bash
 terraform init
```

Validate:
```bash
terraform validate
```
Review the execution plan:

``` bash
 terraform plan
```
Apply the configuration:

```bash 
terraform apply
```
After deployment, you can SSH into the EC2 instances using the respective private keys and instance details.

Notes

Ensure the required SSH key pairs are created and imported into AWS before deployment.

Update the providers and key_name values as necessary for your environment.

Make sure you have adequate permissions for creating VPCs, subnets, EC2 instances, and VPC peering connections.

Cleanup

To destroy all resources created by this configuration, run:
```bash
terraform destroy
```

## Resources Overview

- VPC A in us-west-1 region.

- VPC B in us-west-2 region.

- VPC C in us-east-1 region.

### Each VPC includes:

- CIDR blocks for public and private subnets.

- DNS support and hostnames enabled.

- Availability Zones (AZs) specified for subnet distribution.

### VPC Peering Connections

VPC B to VPC A:

Peering connection initiated from VPC B to VPC A.

Route tables updated in both VPCs to enable private communication.

VPC B to VPC C:

Peering connection initiated from VPC B to VPC C.

Route tables updated in both VPCs.

### EC2 Instances
- VPC A:

Role: Client

Instance Type: t2.micro

Deployed in one private subnet and one public subnet.

- VPC B:

Role: Jump Server

Instance Type: t2.micro

Deployed in a public subnet.

- VPC C:

Role: Server

Instance Type: t2.micro

Deployed in a private subnet.
