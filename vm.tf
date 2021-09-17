# Ubuntu AMI locator
# https://cloud-images.ubuntu.com/locator/ec2/

resource "aws_instance" "onebox" {
  ami                         = "ami-0f0b17182b1d50c14"
  instance_type               = var.vmSize
  key_name                    = var.aws_ssh_key
  monitoring                  = false
  subnet_id                   = aws_subnet.linux_subnet.id
  private_ip                  = var.linux_ip
  vpc_security_group_ids      = [aws_security_group.linux.id]
  associate_public_ip_address = true
  user_data_base64            = base64encode(local.user_data)

  root_block_device {
    volume_size = 30
  }

  tags = "${merge(
    local.common_tags,
    tomap({
      "Name" = var.vmName,
      "VPC" = var.vpc_name
    })
  )}"
}
