project_name                = "eks-platform"
environment                 = "dev"
aws_region                  = "us-east-1"
owner                       = "DevOps-Team"
vpc_cidr                    = "10.0.0.0/16"
single_nat_gateway          = true
cluster_admin_principal_arn = "arn:aws:iam::945788750616:user/terraformuser"
cluster_endpoint_public_access_cidrs = [
  "98.206.14.182/32"
]

availability_zones = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c"
]

public_subnet_cidrs = [
  "10.0.0.0/20",
  "10.0.16.0/20",
  "10.0.32.0/20"
]

private_subnet_cidrs = [
  "10.0.48.0/20",
  "10.0.64.0/20",
  "10.0.80.0/20"
]

cluster_version = "1.35"

cluster_endpoint_private_access = true
cluster_endpoint_public_access  = true

node_instance_types = ["t3.medium"]

node_min_size     = 2
node_desired_size = 2
node_max_size     = 4

node_disk_size     = 30
node_capacity_type = "ON_DEMAND"

node_labels = {
  workload = "general"
}

attach_cni_policy_to_node_role = false
