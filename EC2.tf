
# Creatin 2 EC2
resource "aws_instance" "Test-server1" {
  ami                         = var.server1-ami-id
  instance_type               = var.instance-type-server1
  iam_instance_profile        = aws_iam_instance_profile.test_ec2_profile.id
  key_name                    = var.server1-key-name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Test-sec-group.id]
  subnet_id                   = aws_subnet.Test_Public_Sub1.id
  availability_zone           = var.AZ1

  tags = {
    Name = "Test-server1"
  }
}

resource "aws_instance" "Test-server2" {
  ami                         = var.server2-ami-id
  instance_type               = var.instance-type-server2
  key_name                    = var.server2-key-name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.Test-sec-group.id]
  subnet_id                   = aws_subnet.Test_priv_Sub2.id
  availability_zone           = var.AZ2

  tags = {
    Name = "Test-server2"
  }
}