resource "aws_security_group" "linux" {
  name        = "linux_SG"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  tags = "${merge(
    local.common_tags,
    tomap({
      "Name" = "OneBox_SG"
    })
  )}"
}

resource "aws_security_group_rule" "allow_ssh_ingress" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = [var.AllowedSourceIPRange]

  security_group_id = aws_security_group.linux.id
}

resource "aws_security_group_rule" "allow_console_ingress" {
  type        = "ingress"
  from_port   = 8083
  to_port     = 8084
  protocol    = "tcp"
  cidr_blocks = [var.AllowedSourceIPRange]

  security_group_id = aws_security_group.linux.id
}

resource "aws_security_group_rule" "allow_http_ingress" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = [var.AllowedSourceIPRange]

  security_group_id = aws_security_group.linux.id
}

resource "aws_security_group_rule" "allow_https_ingress" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = [var.AllowedSourceIPRange]

  security_group_id = aws_security_group.linux.id
}

resource "aws_security_group_rule" "allow_all_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.linux.id
}