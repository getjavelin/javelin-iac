output "alb_fe_security_group_id" {
  description = "ALB FE Security Group ID"
  value       = aws_security_group.alb_fe_sg.id
}

output "alb_fe_security_group_name" {
  description = "ALB FE Security Group Name"
  value       = aws_security_group.alb_fe_sg.name
}

output "alb_fe_security_group_arn" {
  description = "ALB FE Security Group arn"
  value       = aws_security_group.alb_fe_sg.arn
}

output "alb_be_security_group_id" {
  description = "ALB BE Security Group ID"
  value       = aws_security_group.alb_be_sg.id
}

output "alb_be_security_group_name" {
  description = "ALB BE Security Group Name"
  value       = aws_security_group.alb_be_sg.name
}

output "alb_be_security_group_arn" {
  description = "ALB BE Security Group arn"
  value       = aws_security_group.alb_be_sg.arn
}

output "alb_security_group_ids" {
  description = "ALB FE and BE Security Group IDs"
  value       = "${aws_security_group.alb_fe_sg.id}, ${aws_security_group.alb_be_sg.id}"
}