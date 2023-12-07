#Here we are using the another subnet because where we are dealing with an map and our input is another map[ex: subnets]
#then we will create the sub-module this is an general practice that will follow.

resource "aws_subnet" "main" {
  for_each            = var.subnets
  vpc_id              = var.vpc_id
  cidr_block          = each.value["cidr"]
  availability_zone   = each.value["az"]

  tags = {
    Name = each.key
  }
}
#we need the cidr and az information so we are looping in to for_each = var.subnets so that we can get cidr and a info
#to create subnet.

resource "aws_route_table" "main" {
  for_each  = var.subnets
  vpc_id    = aws_vpc_id
  tags = {
    Name = each.key
  }
}

variable "subnets" {}
variable "vpc_id" {}

