resource "aws_cloudwatch_event_rule" "lambda" {
  name                = "${var.name}"
  description         = "${replace(var.name, "_", " ")}"
  schedule_expression = "rate(1 minute)"
  is_enabled          = true
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = "${aws_cloudwatch_event_rule.lambda.name}"
  target_id = "${var.name}"
  arn       = "${var.lambda_arn}"
}

resource "aws_lambda_permission" "lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_cloudwatch_event_target.lambda.arn}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.lambda.arn}"
}
