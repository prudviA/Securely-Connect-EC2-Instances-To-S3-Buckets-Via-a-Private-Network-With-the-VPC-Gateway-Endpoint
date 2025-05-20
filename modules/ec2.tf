# crearing instances for bastion host and private instances

resource "aws_instance" "bastion_host" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet.id
  key_name = "cicd"
  vpc_security_group_ids = [aws_security_group.bastion_sg]

  tags = {
    Name = "bastion_host"
  }
}

resource "aws_instance" "privat_instance" {
  ami           = "ami-084568db4383264d4"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private_subnet.id
  key_name = "cicd"
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  iam_instance_profile = aws_iam_instance_profile.s3_profile.id

  tags = {
    Name = "private_instance"
  }
}


resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.s3_vpc.id

  tags = {
    Name = "bastion_sg"
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.s3_vpc.id

  tags = {
    Name = "private_sg"
  }

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    security_groups  =  [aws_security_group.bastion_sg.id]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}