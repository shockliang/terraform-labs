resource "aws_eks_addon" "vpc_cni" {
  cluster_name      = module.eks.cluster_id
  addon_name        = "vpc-cni"
  resolve_conflicts = "OVERWRITE"
  addon_version     = "v1.11.3-eksbuild.1"
  # depends_on = [time_sleep.wait_3_minutes]
  depends_on = [module.eks]
}

resource "aws_eks_addon" "coredns" {
  cluster_name = module.eks.cluster_id
  addon_name   = "coredns"
  addon_version     = "v1.8.7-eksbuild.2"
  resolve_conflicts = "OVERWRITE"

  depends_on = [module.eks.eks_managed_node_groups]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = module.eks.cluster_id
  addon_name   = "kube-proxy"
  addon_version     = "v1.23.7-eksbuild.1"
  resolve_conflicts = "OVERWRITE"
}

# resource "aws_eks_addon" "aws_ebs_csi_driver" {
#   cluster_name = module.eks.cluster_id
#   addon_name   = "aws-ebs-csi-driver"
#   addon_version = "v1.10.0-eksbuild.1"
#   resolve_conflicts = "OVERWRITE"
#   service_account_role_arn = module.aws_ebs_csi_driver_iam
#   depends_on = [module.eks.eks_managed_node_groups, module.aws_ebs_csi_driver_iam]
# }