#BASICDB
#variable "" { default="" type = "string" }
variable "costcenter" { type="string" }
variable "nameprefix" { type="string" }
variable "vpc" { type = "string" }
variable "subnets" { type = "list" }
variable "dbuser" { type="string" }
variable "dbpass" { type="string" }
variable "dbname" { default="db" type="string" }
variable "port" { default="3306" type="string" }
variable "engine" { default="mysql" type="string" }
variable "size" { default="5" type="string" }
variable "instance_class" { default="db.t2.medium" type="string" }
variable "final_snapshot" { default ="" type="string" }
