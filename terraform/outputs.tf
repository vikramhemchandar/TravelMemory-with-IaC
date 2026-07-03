output "web_server_public_ip" {
  description = "Public IP address of the Web Server"
  value       = aws_instance.web.public_ip
}

output "web_server_private_ip" {
  description = "Private IP address of the Web Server"
  value       = aws_instance.web.private_ip
}

output "database_server_private_ip" {
  description = "Private IP address of the Database Server"
  value       = aws_instance.db.private_ip
}

output "detected_client_ip" {
  description = "The client IP address detected and used for security group SSH white-listing"
  value       = chomp(data.http.my_ip.response_body)
}

output "ssh_instruction_web" {
  description = "Command to SSH into the Web Server"
  value       = "ssh -i ${path.module}/${var.project_name}-key.pem ubuntu@${aws_instance.web.public_ip}"
}

output "ssh_instruction_db" {
  description = "Command to SSH into the Database Server (via Web Server jump host)"
  value       = "ssh -i ${path.module}/${var.project_name}-key.pem -o ProxyCommand=\"ssh -i ${path.module}/${var.project_name}-key.pem -W %h:%p ubuntu@${aws_instance.web.public_ip}\" ubuntu@${aws_instance.db.private_ip}"
}
