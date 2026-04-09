terraform {
  backend "s3" {
    bucket         = "nirav-eks-tf-state-ap"
    key            = "prod/eks.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "nirav-tf-lock"
    encrypt        = true
  }
}
