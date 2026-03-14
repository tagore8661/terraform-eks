# # Security Group for EKS Cluster
# resource "aws_security_group" "cluster" {
#   name        = "${var.cluster_name}-cluster-sg"
#   description = "EKS control plane security group"
#   vpc_id      = var.vpc_id

#   # Allow worker nodes to access Kubernetes API
#   ingress {
#     description     = "Worker nodes to Kubernetes API"
#     from_port       = 443
#     to_port         = 443
#     protocol        = "tcp"
#     security_groups = [aws_security_group.node.id]
#   }

#   # Allow outbound traffic
#   egress {
#     description = "Allow all outbound"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name      = "${var.cluster_name}-cluster-sg"
#     ManagedBy = "terraform"
#   }
# }