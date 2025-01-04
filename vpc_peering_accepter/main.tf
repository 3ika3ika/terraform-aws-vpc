resource "aws_vpc_peering_connection_accepter" "accepter" {
  
  vpc_peering_connection_id = var.peering_connection_id
  
  auto_accept               = true
  
}

/*
resource "aws_vpc_peering_connection_options" "accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.accepter.id
  
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}
*/