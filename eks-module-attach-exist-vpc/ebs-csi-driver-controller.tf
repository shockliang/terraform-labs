data "aws_eks_cluster" "cluster" {
  name = local.name
  depends_on = [
    module.eks
  ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = local.name
    depends_on = [
    module.eks
  ]
}

data "tls_certificate" "cert" {
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

# resource "aws_iam_openid_connect_provider" "openid_connect" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.cert.certificates.0.sha1_fingerprint]
#   url             = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
# }

# data "aws_iam_openid_connect_provider" "openid_connect" {
#   arn = data.aws_eks_cluster.cluster.identity[0].oidc[0].arn
# }

module "ebs_csi_driver_controller" {
  source = "DrFaust92/ebs-csi-driver/kubernetes"
  version = "v3.3.1"

  ebs_csi_controller_image                   = ""
  ebs_csi_controller_role_name               = "ebs-csi-driver-controller"
  ebs_csi_controller_role_policy_name_prefix = "ebs-csi-driver-policy"
  oidc_url                                   = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}
