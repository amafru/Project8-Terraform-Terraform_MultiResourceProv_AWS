resource "aws_security_group" "project8-stack-sg" {
  vpc_id      = aws_vpc.project8-vpc.id
  name        = "proj-8-sg"
  description = "project8 SG. Allow ssh from my IP"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
  }

  tags = {
    Name = "project8-sg"
  }
}