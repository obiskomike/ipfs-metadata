# Complete Deployment Guide: Creating ECS with Terraform and Deploying ECS Application

This guide provides step-by-step instructions for creating an Amazon ECR repository using Terraform, pushing Docker images via GitHub Actions, and deploying the application on AWS ECS.

---

## Step 1: Prerequisites

### 1.1 AWS Account Setup
- **AWS Console Access**: Log in to the AWS Management Console.
- **IAM User**: Ensure your IAM user has permissions to manage ECS, ECR, RDS, and VPC resources.
  - Recommended IAM Policy: `AdministratorAccess` (for initial setup).

### 1.2 Install Required Tools
Ensure the following tools are installed:
- **AWS CLI**: [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- **Terraform**: [Install Terraform](https://www.terraform.io/downloads.html)
- **Docker**: [Install Docker](https://www.docker.com/)
- **Git**: [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### 1.3 AWS CLI Configuration
Run the following command to configure your AWS CLI:
```bash
aws configure

Provide the following information:
Access Key ID
Secret Access Key
Default Region (e.g., us-east-1)
Output format (e.g., json).


