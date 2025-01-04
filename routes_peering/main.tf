
resource "aws_route" "route_peering" {
  route_table_id            = var.private_route_table_id  # This VPC route table
  destination_cidr_block    = var.cidr_block       # Target VPC CIDR block 
  vpc_peering_connection_id = var.peering_connection_id  #ID of peering connection
}
