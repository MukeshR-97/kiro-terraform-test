# Test Terraform Configuration
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "echo 'Test resource'"
  }
}
