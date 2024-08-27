# DevOps Project: CI/CD Pipeline with GitHub Actions, Terraform, AWS, and Docker

## Overview

This project demonstrates how to automate the deployment of a Node.js application using a complete DevOps pipeline. The pipeline is built using GitHub Actions, Terraform, AWS (EC2, ECR), and Docker. The application is deployed to an Amazon EC2 instance, provisioned using Terraform, and managed through a CI/CD pipeline.

## Project Structure

- **Node.js Application**: A simple Node.js app that serves a message on port 8080.
- **Docker**: The application is containerized using Docker for consistent deployment.
- **Terraform**: Infrastructure as code (IaC) tool used to provision the EC2 instance and related AWS resources.
- **GitHub Actions**: CI/CD pipeline for automating the deployment process.
- **AWS**: 
  - **EC2**: The instance where the application is deployed.
  - **ECR**: Docker images are stored in AWS Elastic Container Registry (ECR).
  - **S3** : For storing the state files. 

## Technologies Used

- **Node.js**
- **Docker**
- **Terraform**
- **GitHub Actions**
- **AWS EC2**
- **AWS ECR**

## Setup Instructions

### Prerequisites

- Node.js and npm installed
- Docker installed
- AWS CLI configured with the necessary permissions
- Terraform installed
- GitHub repository set up with the required secrets


GitHub Secrets
Ensure the following secrets are set in your GitHub repository:

AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
AWS_SSH_KEY_PRIVATE
AWS_SSH_KEY_PUBLIC
AWS_ECR_REPOSITORY
