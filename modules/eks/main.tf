# EKS Cluster
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.cluster.arn

  vpc_config {
    subnet_ids         = var.subnet_ids
    # security_group_ids = [aws_security_group.cluster.id]
  }

  tags = {
    Name      = var.cluster_name
    ManagedBy = "terraform"
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy
  ]
}

# EKS Node Group
resource "aws_eks_node_group" "main" {
  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.subnet_ids

  instance_types = each.value.instance_types
  capacity_type  = each.value.capacity_type

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }

  tags = {
    Name      = "${aws_eks_cluster.main.name}-${each.key}"
    ManagedBy = "terraform"
  }

  # remote_access {
  #   ec2_ssh_key               = "eks-key"
  #   source_security_group_ids = [aws_security_group.node.id]
  # }

  depends_on = [
    aws_iam_role_policy_attachment.node_policy
  ]
}