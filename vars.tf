variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1c"
}

variable "ZONE3" {
  default = "us-east-1d"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-0f34c5ae932e6f0e4" #Amazon Linux 2023
    eu-west-1 = "ami-05a3d90809a151346" #Amazon Linux 2023
  }
}

variable "USER" {
  default = "ec2-user"
}

variable "PUB_KEY" {
  default = "project8-terraform-key.pub"
}

variable "PRIV_KEY" {
  default = "project8-terraform-key"
}

variable "MYIP" {
  default = "81.137.235.65/32"
}