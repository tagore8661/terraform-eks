# Terraform EKS Cluster

This Terraform module deploys an Amazon EKS (Elastic Kubernetes Service) cluster with all necessary networking components.

## Architecture

The module creates the following resources:

- **VPC** with public and private subnets
- **EKS Cluster** with specified Kubernetes version
- **EKS Node Groups** with configurable instance types and scaling
- **NAT Gateways** for private subnet internet access
- **Internet Gateway** for public subnet access
- **S3 Backend** for Terraform state management
- **DynamoDB Table** for state locking

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate permissions
- An existing S3 bucket and DynamoDB table for backend state (or use the backend module)

## Usage

1. Clone this repository:
```bash
git clone <repository-url>
cd terraform-eks
```

2. Update `variables.tf` with desired values
```bash
vim variables.tf
```

3. Initialize Terraform:
```bash
terraform init
```

4. Plan the deployment:
```bash
terraform plan
```

5. Apply the changes:
```bash
terraform apply
```

## Backend Configuration

The module uses S3 for state storage and DynamoDB for state locking. Configure these variables:

- `backend_bucket`: S3 bucket name for Terraform state
- `backend_dynamodb_table`: DynamoDB table for state locking

## Outputs

- `cluster_endpoint`: EKS cluster API endpoint
- `cluster_name`: EKS cluster name
- `vpc_id`: VPC ID

## Post-Deployment

After the cluster is created, update your kubeconfig:

```bash
aws eks update-kubeconfig --region $(terraform output -raw region) --name $(terraform output -raw cluster_name)
```

Verify the cluster:
```bash
kubectl config current-context
kubectl get nodes
```

## Cleanup

To destroy all resources:
```bash
terraform destroy
```