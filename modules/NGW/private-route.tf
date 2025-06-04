resource "aws_route" "private_nat_gateway" {
  count                  = length(var.private_rt_ids)
  route_table_id         = var.private_rt_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.demo-natgw.id
}
