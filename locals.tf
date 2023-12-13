#Now as we created NAT gateway in the public1 and public2 and we need to create routes for APP and DB subnets so,for that
#we are merging the app and db subnet_ids and app and db route_table_ids.
locals {

#SUBNETS
  public_subnet_ids         = [for k,v in lookup(lookup(module.subnets, "public", null), "subnet_ids", null): v.id]
  app_subnet_ids            = [for k,v in lookup(lookup(module.subnets, "app", null), "subnet_ids", null): v.id]
  db_subnet_ids             = [for k,v in lookup(lookup(module.subnets, "db", null), "subnet_ids", null): v.id]
  private_subnet_ids        = concat (local.app_subnet_ids, local.db_subnet_ids)


#ROUTE TABLE
  public_route_table_ids    = [for k,v in lookup(lookup(module.subnets, "public", null), "route_table_ids", null): v.id]
  app_route_table_ids       = [for k,v in lookup(lookup(module.subnets, "app", null), "route_table_ids", null): v.id]
  db_route_table_ids        = [for k,v in lookup(lookup(module.subnets, "db", null), "route_table_ids", null): v.id]
  private_route_table_ids   = concat (local.app_route_table_ids, local.db_route_table_ids)

}

