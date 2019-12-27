resource "aws_instance" "harbor_instance" {
  ami                     = "${var.harbor_instance["ami"]}"
  instance_type           = "${var.harbor_instance["type"]}"
  disable_api_termination = false
  key_name                = "${var.ec2_keypair}"
  count                   = "${var.harbor_instance["count"]}"
  subnet_id               = "${element(aws_subnet.PublicSubnet.*.id, count.index)}"
  vpc_security_group_ids  = ["${aws_security_group.harbor_instance.id}"]
  tags = {
    Name        = "harbor_instance-${count.index}.${var.environment_tag}"
    Environment = "${var.environment_tag}"
  }
}
resource "aws_eip" "HarborPublicIP" {
  count    = "${var.harbor_instance["count"]}"
  instance = "${element(aws_instance.harbor_instance.*.id, count.index)}"
  vpc      = true
}

