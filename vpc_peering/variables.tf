variable "requester_vpc_id" {
  description = "ID of the requester VPC"
  type        = string
}

variable "accepter_vpc_id" {
  description = "ID of the accepter VPC"
  type        = string
}

variable "accepter_region" {
  description = "Region of the accepter VPC"
  type        = string
}

variable "name" {
  description = "Name of the peering connection"
  type = string 
}

variable "cidr_block" {
  description = "The CIDR block of the VPC."
 type = string 
}
variable "private_route_table_id" {
  description = "The ID of the private route table"
 type = string 
}