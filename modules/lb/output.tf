
output "listener_arn" {
  value = aws_lb_listener.http.arn
}

output "elb_id" {
  value = aws_lb.test.id
}

output "elb_dns_name" {
  value = aws_lb.test.dns_name
}

output "elb_zone_id" {
  value = aws_lb.test.zone_id
}

output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}
