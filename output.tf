
output "OneBox_URL" {
  value = "Access the Console via:  https://${aws_instance.onebox.public_ip}:8083"
}