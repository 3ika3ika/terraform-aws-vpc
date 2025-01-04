variable "cidr_block" {
  description = "The CIDR block of the VPC."
  type = string
}

variable "private_route_table_id" {
  description = "The ID of the private route table"
  type = string
}

variable "peering_connection_id" {
  description = "ID of the VPC peering connection"
  type = string
}