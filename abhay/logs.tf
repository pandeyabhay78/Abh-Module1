# logs.tf

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "symmetrical_spork_log_group" {
  name              = "/ecs/symmetrical_spork-app"
  retention_in_days = 10

  tags = {
    Name = "symmetrical_spork-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "symmetrical_spork_log_stream" {
  name           = "symmetrical_spork-log-stream"
  log_group_name = aws_cloudwatch_log_group.symmetrical_spork_log_group.name
}

