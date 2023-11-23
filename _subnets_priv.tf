resource "aws_subnet" "instance" {
#  availability_zone = data.aws_availability_zones.available.names[0]
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "DummySubnetInstance"
  }
}
