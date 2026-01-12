# ==================== SECURITY GROUP ====================

resource "aws_security_group" "web" {
  name = "web-web-technova"
  description = "Security group pour serveurs web"
  vpc_id      = aws_vpc.main.id

  # ========== INBOUND ==========

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH access"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP access"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS access"
  }

  # ========== OUTBOUND ==========

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound"
  }

  tags = { Name = "sg-web-technova" }
}

# ==================== SSH KEY PAIR ====================

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-technova"
  public_key = file("/home/id00l/.ssh/id_rsa.pub")

  tags = { Name = "deployer-key" }
}