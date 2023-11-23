resource "aws_instance" "ec2jumphost" {
  instance_type = "t2.micro"
  ami = "ami-0283a57753b18025b" # https://cloud-images.ubuntu.com/locator/ec2/ (Ubuntu)
  subnet_id = aws_subnet.nat_gateway.id
  security_groups = [aws_security_group.securitygroup.id]
  key_name = aws_key_pair.ssh.key_name
  disable_api_termination = false
  ebs_optimized = false
  root_block_device {
    volume_size = "10"
  }
  tags = {
    "Name" = "DummyMachineJumphost"
  }
}

resource "aws_eip" "jumphost" {
  instance = aws_instance.ec2jumphost.id
  vpc = true
}

output "jumphost_ip" {
  value = aws_eip.jumphost.public_ip
}
