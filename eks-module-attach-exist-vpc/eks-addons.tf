resource "aws_eks_addon" "vpc_cni" {
  cluster_name      = module.eks.cluster_id
  addon_name        = "vpc-cni"
  resolve_conflicts = "OVERWRITE"
  addon_version     = "v1.11.3-eksbuild.1"
  depends_on = [
    module.eks_managed_node_group,
    module.eks_managed_node_group-t3a
  ]
}

resource "aws_eks_addon" "coredns" {
  cluster_name      = module.eks.cluster_id
  addon_name        = "coredns"
  addon_version     = "v1.8.7-eksbuild.2"
  resolve_conflicts = "OVERWRITE"
  depends_on = [
    module.eks_managed_node_group,
    module.eks_managed_node_group-t3a
  ]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = module.eks.cluster_id
  addon_name        = "kube-proxy"
  addon_version     = "v1.23.7-eksbuild.1"
  resolve_conflicts = "OVERWRITE"
  depends_on = [
    module.eks_managed_node_group,
    module.eks_managed_node_group-t3a
  ]
}

module "iam_assumable_role_admin" {
  source = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"

  create_role = true

  role_name = "ebs-csi-driver-iam"

  tags = {
    Role = "ebs-csi-driver-iam"
  }

  provider_url  = module.eks.oidc_provider
  provider_urls = [module.eks.oidc_provider]

  role_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  ]

  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]

  depends_on = [
    module.eks
  ]
}

resource "aws_eks_addon" "aws_ebs_csi_driver" {
  cluster_name             = module.eks.cluster_id
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.10.0-eksbuild.1"
  resolve_conflicts        = "OVERWRITE"
  service_account_role_arn = module.iam_assumable_role_admin.iam_role_arn
  depends_on = [
    module.eks_managed_node_group,
    module.eks_managed_node_group-t3a,
    module.iam_assumable_role_admin
  ]
}