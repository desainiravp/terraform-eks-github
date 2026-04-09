# EKS Terraform GitHub Repository

This repository contains Terraform configurations for deploying and managing an Amazon Elastic Kubernetes Service (EKS) cluster and its supporting infrastructure on AWS.

## Repository Structure

- **providers.tf**: Defines the required providers (e.g., AWS).
- **versions.tf**: Specifies Terraform and provider version constraints.
- **backend/**: Contains backend configuration for remote state storage.
  - `backend.tf`: Backend configuration file.
- **envs/**: Environment-specific configurations.
  - **prod/**: Production environment.
    - `backend.tf`: Backend configuration for production.
    - `main.tf`: Main Terraform configuration for production.
    - `outputs.tf`: Output variables for production.
    - `terraform.tfstate`, `terraform.tfstate.backup`: State files (should be in .gitignore).
    - `terraform.tfvars`: Variable values for production.
    - `variables.tf`: Variable definitions for production.
    - `versions.tf`: Version constraints for production.
- **modules/**: Reusable Terraform modules.
  - **eks/**: EKS cluster module.
    - `main.tf`, `outputs.tf`, `variables.tf`
  - **vpc/**: VPC module.
    - `main.tf`, `outputs.tf`, `variables.tf`

## Getting Started

### Prerequisites
- [Terraform](https://www.terraform.io/downloads.html) >= 1.0.0
- AWS CLI configured with appropriate credentials

### Usage

1. Clone the repository:
  ```sh
  git clone <repo-url>
  cd eks-terraform-github
  ```
2. Initialize Terraform:
  ```sh
  terraform init
  ```
3. Plan the deployment:
  ```sh
  terraform plan -var-file="envs/prod/terraform.tfvars"
  ```
4. Apply the configuration:
  ```sh
  terraform apply -var-file="envs/prod/terraform.tfvars"
  ```

## Accessing Kubernetes Cluster

After applying the Terraform configuration, update your kubeconfig to access the EKS cluster:

```sh
aws eks --region <region> update-kubeconfig --name <cluster_name>
```

## Installing Metrics Server and HPA

1. **Install Metrics Server:**
  ```sh
  kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
  ```
  Verify installation:
  ```sh
  kubectl get deployment metrics-server -n kube-system
  ```

2. **Deploy a sample application (optional):**
  ```sh
  kubectl create deployment nginx --image=nginx
  kubectl expose deployment nginx --port=80 --type=NodePort
  ```

3. **Create an HPA (Horizontal Pod Autoscaler):**
  ```sh
  kubectl autoscale deployment nginx --cpu-percent=50 --min=1 --max=5
  ```
  Check HPA status:
  ```sh
  kubectl get hpa
  ```

**Note:** Ensure your cluster nodes have the necessary IAM permissions for metrics-server and that your security groups allow required traffic.

## Folder Structure
```
providers.tf
versions.tf
backend/
  backend.tf
envs/
  prod/
    backend.tf
    main.tf
    outputs.tf
    terraform.tfstate
    terraform.tfstate.backup
    terraform.tfvars
    variables.tf
    versions.tf
modules/
  eks/
    main.tf
    outputs.tf
    variables.tf
  vpc/
    main.tf
    outputs.tf
    variables.tf
```

## Notes
- State files should not be committed to version control. Add them to `.gitignore`.
- Customize variables in `terraform.tfvars` as needed for your environment.

## License
Specify your license here.
