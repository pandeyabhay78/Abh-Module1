# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "assignment_app_log_group" {
  name              = "/ecs/assignment_app-app"
  retention_in_days = 10

  tags = {
    Name = "assignment_app-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "assignment_app_log_stream" {
  name           = "assignment_app-log-stream"
  log_group_name = aws_cloudwatch_log_group.assignment_app_log_group.name
}

