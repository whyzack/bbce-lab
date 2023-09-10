module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "bbce-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id                   = "vpc-0b80209aba4b2cd45"
  subnet_ids               = ["subnet-02a85ff570c1d929f","subnet-04430b3d65b326aa2"]
  control_plane_subnet_ids = ["subnet-02a85ff570c1d929f","subnet-04430b3d65b326aa2"]


  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.small"]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 1

      instance_types = ["t2.small"]
    }
  }

#  # Fargate Profile(s)
#  fargate_profiles = {
#    default = {
#      name = "default"
#      selectors = [
#        {
#          namespace = "default"
#        }
#      ]
#    }
#  }

  # aws-auth configmap
  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = "arn:aws:iam::044723872363:role/test"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::044723872363:user/isaac"
      username = "user1"
      groups   = ["system:masters"]
    }
  ]

  aws_auth_accounts = [
    "044723872363"
  ]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
