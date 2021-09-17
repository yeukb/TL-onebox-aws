data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = "${merge(
    local.common_tags,
    tomap({
      "Name" = var.vpc_name
    })
  )}"
}

resource "aws_subnet" "linux_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.linux_subnet
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = "${merge(
    local.common_tags,
    tomap({
      "Name" = "OneBox_subnet"
    })
  )}"
}


resource "aws_route_table" "linux_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = "${merge(
    local.common_tags,
    tomap({
      "Name" = "OneBox_RT"
    })
  )}"
}


resource "aws_route_table_association" "linux_rt_association" {
  subnet_id      = aws_subnet.linux_subnet.id
  route_table_id = aws_route_table.linux_rt.id
}


resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = "${merge(
    local.common_tags,
    tomap({
      "Name" = "${var.vpc_name}-igw"
    })
  )}"
}


resource "aws_route" "linux_rt_default_route" {
  route_table_id         = aws_route_table.linux_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.vpc_igw.id
}
