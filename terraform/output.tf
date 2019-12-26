# Outputs
output "HarborPublicIP" {
  value = ["${aws_eip.HarborPublicIP.*.public_ip}"]
}
