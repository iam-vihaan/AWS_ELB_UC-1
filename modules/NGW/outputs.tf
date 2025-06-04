output "natgw_id" {
  value = aws_nat_gateway.demo-natgw.id
}
output "natgw_eip" {
  value = aws_eip.nat.id
}
