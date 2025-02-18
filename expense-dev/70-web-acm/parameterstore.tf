resource "aws_ssm_parameter" "web_certificate_arn" {
  name  = "/${var.project}/${var.environment}/web_certificate_arn"
  type  = "String"
  value = aws_acm_certificate.web.arn
}