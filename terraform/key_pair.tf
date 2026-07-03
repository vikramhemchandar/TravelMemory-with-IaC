# 1. Generate a new private key
resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Register key with AWS
resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-key"
  public_key = tls_private_key.key.public_key_openssh

  tags = {
    Name        = "${var.project_name}-key"
    Project     = var.project_name
    Environment = "Dev"
  }
}

# 3. Save the private key locally
resource "local_file" "private_key" {
  content         = tls_private_key.key.private_key_pem
  filename        = "${path.module}/${var.project_name}-key.pem"
  file_permission = "0400"
}
