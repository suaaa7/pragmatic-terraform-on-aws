resource "aws_sfn_state_machine" "sfn" {
  name = "sfn"
  role_arn = aws_iam_role.sfn.arn

  definition = data.template_file.sfn.rendered
}

data "template_file" "sfn" {
  template = file("./step_function.json")

  vars = {
    lambda-arn = aws_lambda_function.lambda.arn
    lambda-arn2 = aws_lambda_function.lambda.arn
  }
}
