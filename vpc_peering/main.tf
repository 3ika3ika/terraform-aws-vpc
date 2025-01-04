resource "aws_vpc_peering_connection" "requester" {
  vpc_id     = var.requester_vpc_id
  peer_vpc_id = var.accepter_vpc_id
  peer_region = var.accepter_region
  auto_accept = false # BLQQQQQQQQQQQQQQQQTTTTTTTTTTTT MONTHS TOOK ME TO FIND IT OUT !!!!!!!!!!!!!!!!!!!
  
  tags = {
    Name = var.name
  }

}

/*
resource "aws_vpc_peering_connection_options" "requester" {
  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  
   requester {
    allow_remote_vpc_dns_resolution = true
  }
}

*/


resource "aws_route" "requester" {
 /* count                     = length(var.private_route_table_id) > 0 ? 1 : 0 */
  route_table_id            = var.private_route_table_id
  destination_cidr_block    = var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.requester.id
  
}
