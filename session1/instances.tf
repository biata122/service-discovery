resource "aws_instance" "consul_server" {
  count=3

  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name
  user_data              = file("consul-server.sh")
  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.opsschool_consul.id]

  tags = {
    Name = "SD-opsschool-server-${count.index+1}"
    consul_server = "true"
  }

}

resource "aws_instance" "consul_agent" {

  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  key_name      = var.key_name
  user_data              = file("consul-agent.sh")
  iam_instance_profile   = aws_iam_instance_profile.consul-join.name
  vpc_security_group_ids = [aws_security_group.opsschool_consul.id]

  tags = {
    Name = "SD-opsschool-agent"
  }

}

output "servers_public_dns" {
  value = aws_instance.consul_server.*.public_dns
}

output "agent_public_dns" {
  value = aws_instance.consul_agent.public_dns
}

output "agent_public_ip" {
  value = aws_instance.consul_agent.public_ip
}