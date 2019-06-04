resource "aws_security_group" "endpoint" {
  count = "${var.create_vpc ? 1 : 0}"

  name        = "${var.endpoint_security_group_name}"
  description = "For VPC Endpoints"
  vpc_id      = "${local.vpc_id}"

  tags = "${merge(
    map("Name", "${var.endpoint_security_group_name}"),
    map("Terraform", "true"),
    var.tags
  )}"
}

resource "aws_security_group_rule" "endpoint_in_443" {
  count = "${var.create_vpc ? 1 : 0}"

  security_group_id = "${aws_security_group.endpoint.id}"
  type              = "ingress"
  description       = "From VPC CIDR"

  cidr_blocks = ["${var.cidr}"]
  protocol    = "tcp"
  from_port   = 443
  to_port     = 443
}
