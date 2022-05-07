data "aws_availability_zones" "available" {}

module "vpc-eks-test" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-eks-test"
  cidr = "10.0.0.0/16"

  azs             = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/20"]
  public_subnets       = ["10.0.64.0/20", "10.0.80.0/20", "10.0.96.0/20"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  enable_dns_hostnames = true


  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    Terraform = "true"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}