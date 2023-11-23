resource "aws_instance" "ec2instance" {
  instance_type = "t2.large"
  ami = "ami-0283a57753b18025b" # https://cloud-images.ubuntu.com/locator/ec2/ (Ubuntu)
  subnet_id = aws_subnet.instance.id
  security_groups = [aws_security_group.securitygroup.id]
  key_name = aws_key_pair.ssh.key_name

  /*
  disable_api_termination = false
  ebs_optimized = false
  root_block_device {
    volume_size = "25"
  }
  */

  tags = {
    "Name" = "DummyMachine"
  }
}

output "instance_private_ip" {
/*
depends_on = [
        aws_instance.ec2instance
    ]
*/
  value = aws_instance.ec2instance.private_ip
}

resource "local_file" "instance_private_ip" {
  depends_on = [
        aws_instance.ec2instance
    ]


  content = "${aws_instance.ec2instance.private_ip}"
  filename = "instance_private_ip.txt"
}
