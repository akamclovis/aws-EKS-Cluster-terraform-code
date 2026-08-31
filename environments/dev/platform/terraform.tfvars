project_name = "eks-platform"
environment  = "dev"
aws_region   = "us-east-1"
owner        = "DevOps-Team"

state_bucket_name   = "eks-platform-terraform-state-945788750616"
state_bucket_region = "us-east-1"
core_state_key      = "eks-platform/dev/core.tfstate"

# Before the next infrastructure rebuild, resolve compatible EKS 1.35 versions
# and pin them here. Null temporarily preserves AWS/EKS version discovery.
vpc_cni_addon_version            = "v1.22.4-eksbuild.3"
coredns_addon_version            = "v1.13.2-eksbuild.21"
kube_proxy_addon_version         = "v1.35.3-eksbuild.21"
pod_identity_agent_addon_version = "v1.3.10-eksbuild.3"
efs_csi_addon_version            = "v3.4.2-eksbuild.1"
