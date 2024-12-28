provider "aws" {
  region = "us-east-1"
}

#################################################
#variables
#################################################

variable "subnet_cidr_block" {
  description = "subnet cidr"
  type = list(string)
}

variable "dev_subnet1_cidre" {
description = "subnet cidr"
}

variable "vpc_cidr" {
  description = "vpc cidr"
}

variable "env" {
  description = "dev"
  
}

####################################################
#Data
####################################################
data "aws_vpc" "existing_vpc" {
  default = true
}
#####################################################

resource "aws_vpc" "dev_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name : "devvpc"
  }

}


resource "aws_subnet" "dev-subnet-1" {
  vpc_id            = aws_vpc.dev_vpc.id
  cidr_block        = var.dev_subnet1_cidre
  availability_zone = "us-east-1a"

  tags = {
    Name : var.env
  }

}


resource "aws_subnet" "dev-subnet-2" {
  vpc_id            = data.aws_vpc.existing_vpc.id
  cidr_block        = var.subnet_cidr_block[0]
  availability_zone = "us-east-1a"

  tags = {
    Name : "dev-subnet-default",
    project : "terraform",
    environment : var.env
  }
}

output "vpc_id" {
  value = aws_vpc.dev_vpc.id

}

output "dev2_subnet_arn" {
  value = aws_subnet.dev-subnet-1.arn

}