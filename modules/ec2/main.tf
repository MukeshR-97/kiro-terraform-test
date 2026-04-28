# 🔐 Security Group (1 per EC2)
resource "aws_security_group" "this" {
  count = var.instance_count

  name   = "${var.project_name}-${var.instance_name}-sg-${count.index + 1}"
  vpc_id = var.vpc_id

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.instance_name}-sg-${count.index + 1}"
  })
}

# 🔐 Dynamic Ingress Rules (mapped per SG)
resource "aws_security_group_rule" "ingress" {
  count = var.instance_count * length(var.ingress_rules)

  type = "ingress"

  security_group_id = aws_security_group.this[
    floor(count.index / length(var.ingress_rules))
  ].id

  description = var.ingress_rules[count.index % length(var.ingress_rules)].description
  from_port   = var.ingress_rules[count.index % length(var.ingress_rules)].from_port
  to_port     = var.ingress_rules[count.index % length(var.ingress_rules)].to_port
  protocol    = var.ingress_rules[count.index % length(var.ingress_rules)].protocol
  cidr_blocks = var.ingress_rules[count.index % length(var.ingress_rules)].cidr_blocks
}

# 🌐 Allow all outbound (per SG)
resource "aws_security_group_rule" "egress" {
  count = var.instance_count

  type              = "egress"
  security_group_id = aws_security_group.this[count.index].id

  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# 💻 EC2 Instance
resource "aws_instance" "this" {
  count = var.instance_count

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name

  # Disable auto public IP if EIP is used
  associate_public_ip_address = var.associate_eip ? false : var.is_public

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }

  # 🔗 Attach matching SG
  vpc_security_group_ids = [
    aws_security_group.this[count.index].id
  ]

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.instance_name}-server-${count.index + 1}"
  })
}

# 🌐 Elastic IP (optional per EC2)
resource "aws_eip" "this" {
  count  = var.associate_eip ? var.instance_count : 0
  domain = "vpc"

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${var.instance_name}-eip-${count.index + 1}"
  })
}

# 🔗 Attach EIP to matching EC2
resource "aws_eip_association" "this" {
  count = var.associate_eip ? var.instance_count : 0

  instance_id   = aws_instance.this[count.index].id
  allocation_id = aws_eip.this[count.index].id
}