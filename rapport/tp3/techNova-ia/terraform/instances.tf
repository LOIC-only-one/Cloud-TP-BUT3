# ==================== DATA : Trouver AMI Ubuntu ====================

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ==================== EC2 INSTANCES ====================

resource "aws_instance" "web" {
  count              = var.instance_count
  ami                = data.aws_ami.ubuntu.id
  instance_type      = var.instance_type
  key_name           = aws_key_pair.deployer.key_name
  subnet_id          = aws_subnet.public.id
  security_groups    = [aws_security_group.web.id]
  monitoring         = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
    encrypted             = true
  }

  tags = {
    Name = "web-technova-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.main]

  lifecycle {
    create_before_destroy = true
  }
}