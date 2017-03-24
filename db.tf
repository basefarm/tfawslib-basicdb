resource "aws_db_instance" "db" {
    tags {
        CostCenter = "${var.costcenter}"
        Name       = "${var.nameprefix}"
    }
    identifier = "${lower(var.costcenter)}-${lower(var.nameprefix)}"
  allocated_storage    = "${var.size}"
  engine               = "${var.engine}"
  instance_class       = "${var.instance_class}"
  name                 = "${var.dbname}"
  username             = "${var.dbuser}"
  password             = "${var.dbpass}"
  db_subnet_group_name = "${lower(var.costcenter)}-${lower(var.nameprefix)}"
  vpc_security_group_ids = ["${aws_security_group.db.id}"]
  skip_final_snapshot = "${var.final_snapshot == "" ? true : false }"
  #final_snapshot_identifier = "${var.final_snapshot == "" ? 0 : var.final_snapshot }"
}
resource "aws_db_subnet_group" "db" {
    tags {
        CostCenter = "${var.costcenter}"
        Name       = "${var.nameprefix}"
    }
    name = "${lower(var.costcenter)}-${lower(var.nameprefix)}"
    subnet_ids = ["${var.subnets}"]
}

resource "aws_security_group" "db" {
  name        = "${lower(var.costcenter)}-${lower(var.nameprefix)}_db"
  description = "Securitygroup for database servers"
  vpc_id = "${var.vpc}"
  tags {
    CostCenter = "${var.costcenter}"
    Name = "${var.nameprefix}_db"
  }
}
resource "aws_security_group" "db_access" {
  name        = "${lower(var.costcenter)}-${lower(var.nameprefix)}_db_access"
  description = "Securitygroup for giving access to database servers"
  vpc_id = "${var.vpc}"
  tags {
    CostCenter = "${var.costcenter}"
    Name = "${var.nameprefix}_db_access"
  }
}
resource "aws_security_group_rule" "db_01" {
  security_group_id = "${aws_security_group.db.id}"
  type            = "ingress"
  from_port       = "${aws_db_instance.db.port}"
  to_port         = "${aws_db_instance.db.port}"
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.db_access.id}"
}
resource "aws_security_group_rule" "db_access_01" {
  security_group_id = "${aws_security_group.db_access.id}"
  type            = "egress"
  from_port       = "${aws_db_instance.db.port}"
  to_port         = "${aws_db_instance.db.port}"
  protocol        = "tcp"
  source_security_group_id = "${aws_security_group.db.id}"
}

output "port" { value = "${aws_db_instance.db.port}" }
output "host" { value = "${aws_db_instance.db.address}" }
output "sg" { value = "${aws_security_group.db_access.id}" }