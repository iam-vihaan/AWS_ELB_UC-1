output "target_group_arn" {
  value = aws_lb_target_group.demo-tg.arn
}

output "load_balancer_arns" {
  value = aws_lb_target_group.demo-tg.load_balancer_arns
}

output "tg_id" {
  value = aws_lb_target_group.demo-tg.id

}
