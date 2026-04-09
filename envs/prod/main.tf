module "vpc" {
  source = "../../modules/vpc"

  name = "nirav-eks-vpc"
  cidr = "10.0.0.0/16"

  azs = ["ap-south-1a", "ap-south-1b"]

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
}

module "eks" {
  source = "../../modules/eks"

  cluster_name       = "nirav-eks"
  kubernetes_version = var.kubernetes_version

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
}

#module "autoscaler" {
#  source = "../../modules/autoscaler"

 # oidc_provider_arn = module.eks.oidc_provider_arn
#}
