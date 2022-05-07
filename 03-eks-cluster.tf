module "eks" {
    source = "terraform-aws-modules/eks/aws"
    cluster_name = local.cluster_name
    cluster_version = "1.22"
    subnet_ids = module.vpc-eks-test.private_subnets

    vpc_id = module.vpc-eks-test.vpc_id

    eks_managed_node_group_defaults = {
        root_volume_type = "gp2"
    }

    eks_managed_node_groups = {
        green = {
            min_size = 2
            max_size = 3
            desired_size = 2
            instance_types = [local.instance_type]
            disk_size = local.root_volume_size
        }
    }
}