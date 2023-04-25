output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}
output "private_subnet_ids" {
  value = join(",", aws_subnet.private.*.id)
}
output "alarm_sns_topic" {
  value = aws_sns_topic.alarm_sns_topic.arn
}