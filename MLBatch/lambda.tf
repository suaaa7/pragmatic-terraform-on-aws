data "archive_file" "lambda" {
  type = "zip"
  source_dir = "src"
  output_path = "src/upload/test.zip"
}

resource "aws_lambda_function" "lambda" {
  filename = data.archive_file.lambda.output_path
  source_code_hash = data.archive_file.lambda.output_base64sha256
  function_name = "lambda"
  role = aws_iam_role.lambda.arn
  handler = "lambda_function.lambda_handler"
  runtime = "python3.6"

  memory_size = 128
  timeout = 30
}
