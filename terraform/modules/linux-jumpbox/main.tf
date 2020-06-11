resource "random_password" "password" {
  length = 16
  special = false
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.tpl")}"

  vars = {
    username = var.default_username
    password = random_password.password.result
  }
}

data "aws_ami" "latest-jumpbox-image" {
  most_recent = true
  owners      = ["724603229804"]

  filter {
    name = "name"
    values = ["linux-jumpbox*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "jumpbox" {
  ami                  = data.aws_ami.latest-jumpbox-image.id
  instance_type        = "t2.small"
  user_data            = data.template_file.user_data.rendered
  key_name             = var.key_pair

  network_interface {
    network_interface_id = aws_network_interface.jumpbox_mgmt.id
    device_index         = 0
  }

  tags = merge(map("Name", "${var.name_prefix}-jumpbox"), var.default_tags)
}

resource "aws_eip" "jumpbox_mgmt" {
  vpc        = true
  network_interface         = aws_network_interface.jumpbox_mgmt.id
  associate_with_private_ip = var.mgmt_private_ip

  tags = merge(map("Name", "${var.name_prefix}-jumpbox"), var.default_tags)

  depends_on = [aws_instance.jumpbox]
}

resource "aws_network_interface" "jumpbox_mgmt" {
  subnet_id                   = var.subnet_id
  security_groups             = [aws_security_group.jumpbox.id]
  private_ips                 = [var.mgmt_private_ip]

  tags = merge(map("Name", "${var.name_prefix}-jumpbox"), var.default_tags)
}

data "aws_network_interface" "jumpbox_mgmt" {
  id = aws_network_interface.jumpbox_mgmt.id
}

resource "aws_security_group" "jumpbox" {
  name        = "${var.name_prefix}-jumpbox"
  description = "Allow inbound ssh and rdp traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}