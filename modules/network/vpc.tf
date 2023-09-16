# ---------------------------------------
# VPC
# ---------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block.vpc
  # Support name resolution by DNS
  enable_dns_support = true
  # Allow instances with public IP addresses to obtain corresponding DNS hostnames
  enable_dns_hostnames = true
  # Multiple AWS accounts may share the same physical EC2 hardware
  instance_tenancy = "default"

  tags = {
    Name = "${var.project}-${var.environment}-vpc"
  }
}

# ---------------------------------------
# Public Subnet(ingress)
# ---------------------------------------
resource "aws_subnet" "public-subnet-ingress-1a" {
  vpc_id = aws_vpc.vpc
  availability_zone = "ap-northeast-1a"
  cidr_block = var.cidr_block.public_subnet_ingress_1a
  # Whether automatically assigns public IPs to instances launched on the subnet or not
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.environment}-public-subnet-ingress-1a"
    Type = "public"
  }
}

resource "aws_subnet" "public-subnet-ingress-1c" {
  vpc_id = aws_vpc.vpc
  availability_zone = "ap-northeast-1c"
  cidr_block = var.cidr_block.public_subnet_ingress_1c
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project}-${var.environment}-public-subnet-ingress-1c"
    Type = "public"
  }
}

# ---------------------------------------
# Private Subnet(application)
# ---------------------------------------
resource "aws_subnet" "private-subnet-application-1a" {
  vpc_id = aws_vpc.vpc
  availability_zone = "ap-northeast-1a"
  cidr_block = var.cidr_block.private_subnet_application_1a
  # Whether automatically assigns public IPs to instances launched on the subnet or not
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.environment}-private-subnet-application-1a"
  }
}

resource "aws_subnet" "private-subnet-application-1c" {
  vpc_id = aws_vpc.vpc
  availability_zone = "ap-northeast-1c"
  cidr_block = var.cidr_block.private_subnet_application_1c
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.environment}-private-subnet-application-1c"
  }
}

# ---------------------------------------
# Private Subnet(Database)
# ---------------------------------------
resource "aws_subnet" "private-subnet-db-1a" {
  vpc_id = aws_vpc.vpc
  availability_zone = "ap-northeast-1a"
  cidr_block = var.cidr_block.private_subnet_db_1a
  # Whether automatically assigns public IPs to instances launched on the subnet or not
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.environment}-private-subnet-db-1a"
  }
}

resource "aws_subnet" "private-subnet-db-1c" {
  vpc_id = aws_vpc.vpc
  availability_zone = "ap-northeast-1c"
  cidr_block = var.cidr_block.private_subnet_db_1c
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.environment}-private-subnet-db-1c"
  }
}

# ---------------------------------------
# Private Subnet(Egress)
# ---------------------------------------
resource "aws_subnet" "private-subnet-egress-1a" {
  vpc_id = aws_vpc.vpc
  availability_zone = "ap-northeast-1a"
  cidr_block = var.cidr_block.private_subnet_egress_1a
  # Whether automatically assigns public IPs to instances launched on the subnet or not
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.environment}-private-subnet-egress-1a"
  }
}

resource "aws_subnet" "private-subnet-egress-1c" {
  vpc_id = aws_vpc.vpc
  availability_zone = "ap-northeast-1c"
  cidr_block = var.cidr_block.private_subnet_egress_1c
  # Whether automatically assigns public IPs to instances launched on the subnet or not
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project}-${var.environment}-private-subnet-egress-1c"
  }
}

# ---------------------------------------
# Internet Gateway
# ---------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc

  tags = {
    Name = "${var.project}-${var.environment}-igw"
  }
}

# ---------------------------------------
# Route Table
# ---------------------------------------
resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc

  tags = {
    Name = "${var.project}-${var.environment}-route-table-public"
  }
}

# ---------------------------------------
# Route Table (Ingress)
# ---------------------------------------
resource "aws_route" "route" {
  route_table_id = aws_route_table.route_table.id
  gateway_id = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# ---------------------------------------
# Assign Route Table
# ---------------------------------------
resource "aws_route_table_association" {
  route_table_id = aws_route_table.route_table_public.id
  subnet_id = aws_subnet.public_subnet_ingress_1a.id
}

resource "aws_route_table_association" {
  route_table_id = aws_route_table.route_table_public.id
  subnet_id = aws_subnet.public_subnet_ingress_1c.id
}

# ---------------------------------------
# Route Table (ECS・RDS)
# ---------------------------------------
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project}-${var.environment}-route-table-private"
  }
}

# ---------------------------------------
# Assign Route Table
# ---------------------------------------
resource "aws_route_table_association" {
  route_table_id = aws_route_table.route_table_private.id
  subnet_id = aws_subnet.private_subnet_application_1a.id
}

resource "aws_route_table_asociation" {
  route_table_id = aws_route_table.route_table_private.id
  subnet_id = aws_subnet.private_subnet_application_1c.id
}

resource "aws_route_table_association" {
  route_table_id = aws_route_table.route_table_private.id
  subnet_id = aws_subnet.private_subnet_db_1a.id
}

resource "aws_route_table_association" {
  route_table_id = aws_route_table.route_table_private.id
  subnet_id = aws_subnet.private_subnet_db_1c.id
}

resource "aws_route_table_association" {
  route_table_id = aws_route_table.route_table_private.id
  subnet_id = aws_subnet.private_subnet_egress_1a.id
}

resource "aws_route_table_association" {
  route_table_id = aws_route_table.route_table_private.id
  subnet_id = aws_subnet.private_subnet_egress_1c.id
}

# ---------------------------------------
# VPC Endpoint(Gateway)
# ---------------------------------------
resource "aws_vpc_endpoint" "gateway_vpc_endpoint_for_s3" {
  vpc_id = aws_vpc.id
  # the service name is usually in the form "com.amazonaws.<region>.<service>"
  service_name = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"

  tags = {
    Name = "${var.project}-${var.environment}-gateway-vpc-endpoint-for-s3"
  }
}

# Gateway type needs to be tied to the ECS subnet's root table
resource "aws_vpc_endpoint_route_table_association" "gateway_vpc_endpoint_association_for_s3" {
  vpc_endpoint_id = aws_vpc_endpoint.gateway_vpc_endpoint_for_s3.id
  route_table_id = aws_route_table.route_table_private
}

# ---------------------------------------
# VPC Endpoint(Interface)
# ---------------------------------------
resource "aws_vpc_endpoint" "interface_vpc_endpoint_for_ecr" {
  vpc_id = aws_vpc.id
  service_name = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_name = "Interface"
  subnet_ids = [
    aws_subnet.aws_subnet.private-subnet-egress-1a,
    aws_subnet.aws_subnet.private-subnet-egress-1c
  ]
  # todo: SGの設定が完了したら、該当するSGのidをセットすること
  security_group_ids = [
  ]
  private_dns_enabled = true

  tags = {
    Name = "${var.project}-${var.environment}-interface-vpc-endpoint-for-ecr"
  }
}
