#Here we are using the another subnet because where we are dealing with an map and our input is another map[ex: subnets]
#then we will create the sub-module this is an general practice that will follow. So,as we created subnet following we
#will create the route table and association also as they come under this subnet creation

resource "aws_subnet" "main" {
  for_each            = var.subnets
  vpc_id              = var.vpc_id
  cidr_block          = each.value["cidr"]
  availability_zone   = each.value["az"]
  tags                = merge(var.tags, { Name = "${var.env}-${each.key}-subnet}"})
   }
#we need the cidr and az information so we are looping in to for_each = var.subnets so that we can get cidr and a info
#to create subnet.

resource "aws_route_table" "main" {
  for_each  = var.subnets
  vpc_id    = var.vpc_id
  tags      = merge(var.tags, { Name = "${var.env}-${each.key}-rt}"})
}

resource "aws_route_table_association" "a" {
  for_each       = var.subnets
  subnet_id      = lookup(lookup(aws_subnet.main, each.key, null), "id", null)
  route_table_id = lookup(lookup(aws_route_table.main, each.key, null), "id", null)
}


