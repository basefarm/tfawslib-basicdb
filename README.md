# tfawslib-basicdb
Terraform module implementing a basic MySQL instance on AWS

## Required Inputs:  
+ variable "costcenter" { type="string" }  
+ variable "nameprefix" { type="string" }  
+ variable "vpc" { type = "string" }  
+ variable "subnets" { type = "list" } - List of subnets where the DB should be available  
+ variable "dbuser" { type="string" } - Username for connecting to database
+ variable "dbpass" { type="string" } - Password for connecting to database

## Optional Inputs:  
+ variable "dbname" { default="db" type="string" }
+ variable "engine" { default="mysql" type="string" } - Database Engine to use
+ variable "size" { default="1" type="string" }  - Size in GB
+ variable "instance_class" { default="db.t2.medium" type="string" } - RDS instance class
+ variable "final_snapshot" { default ="" type="string" } - Define this if you want a final snapshot when destroying the instance
## Outputs:  
+ "sg" - Security group that can be used for accessing the database
+ "host" - Hostname for accessing the database
+ "port" - TCP Port of accessing the database

## Example:  
(Assumes the usage of the VPC example or similar)  
```hcl
module "db" {
#    source = "git@github.com:basefarm/tfawslib-basicdb"
    source = "/home/bent/shared/Documents/Terraform_Module_Library/tfawslib-basicdb"
    costcenter = "${var.costcenter}"
    nameprefix = "${var.nameprefix}"
    vpc = "${module.vpc.vpcid}"
    subnets = "${module.vpc.appnets}"
    dbpass = "Secret#"
    dbuser = "basefarmer"
    dbname = "cmsdemo"

}

output "port" { value = "${module.db.port}" }
output "host" { value = "${module.db.host}"
output "sg" { value = "${module.db.sg}" }

```