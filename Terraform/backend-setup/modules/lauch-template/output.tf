output "launch_template_id" {
  value = aws_launch_template.app.id
}

output "launch_template_version" {
  value = aws_launch_template.app.latest_version
}