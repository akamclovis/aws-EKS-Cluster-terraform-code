output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.this.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC."
  value       = aws_vpc.this.cidr_block
}

output "public_subnet_ids" {
  description = "Public subnet IDs ordered by availability_zones."
  value       = [for az in var.availability_zones : aws_subnet.public[az].id]
}

output "public_subnet_ids_by_az" {
  description = "Public subnet IDs keyed by Availability Zone."
  value = {
    for az in var.availability_zones :
    az => aws_subnet.public[az].id
  }
}

output "private_subnet_ids" {
  description = "Private subnet IDs ordered by availability_zones."
  value       = [for az in var.availability_zones : aws_subnet.private[az].id]
}

output "private_subnet_ids_by_az" {
  description = "Private subnet IDs keyed by Availability Zone."
  value = {
    for az in var.availability_zones :
    az => aws_subnet.private[az].id
  }
}

output "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks ordered by availability_zones."
  value       = [for az in var.availability_zones : aws_subnet.public[az].cidr_block]
}

output "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks ordered by availability_zones."
  value       = [for az in var.availability_zones : aws_subnet.private[az].cidr_block]
}

output "availability_zones" {
  description = "Availability Zones used by the networking module."
  value       = var.availability_zones
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway attached to the VPC."
  value       = aws_internet_gateway.this.id
}

output "nat_gateway_ids" {
  description = "NAT Gateway IDs ordered by NAT Gateway Availability Zone."
  value       = [for az in local.nat_gateway_zones : aws_nat_gateway.this[az].id]
}

output "public_route_table_id" {
  description = "ID of the public route table."
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Private route table IDs ordered by availability_zones."
  value       = [for az in var.availability_zones : aws_route_table.private[az].id]
}
