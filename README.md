##Jenkins Deployment in EC2 Using Terraform .

 
step1:Create an AWS ec2 instance  of Linux machine    using AWS Linux AMI
      usning instance type t2.micro
      Edit the Linux machine's security group and inbound rule custom/TCP allow port 8080

step2:Connect to Ec2 instance terminal
      Install GIT:sudo yum install git -y
      Installation of jenkins packages:

      sudo wget -O /etc/yum.repos.d/jenkins.repo     https://pkg.jenkins.io/redhat-stable/jenkins.repo
      sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
      sudo yum upgrade
      sudo dnf install java-17-amazon-corretto -y
      sudo yum install jenkins -y
	  
	  Installation of AWS:
	  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
      unzip awscliv2.zip
      sudo ./aws/install
	  Installation of Terraform :
	  sudo yum install -y yum-utils shadow-utils
      sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
      sudo yum -y install terraform
	  
	  Create a simple Terraform configuration to deploy an EC2 instance. For example, you can create a file named main.tf in your repository.
	  main.tf file
	  


      terraform {
        required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 4.16"
      }
     }

    }

    provider "aws" {
    region  = "us-east-1"
    }

    resource "aws_instance" "app_server" {
    ami           = "ami-0ae8f15ae66fe8cda"
    instance_type = "t2.micro"

    tags = {
    Name = "myfirstterraform instance"
    }
    }


	  
step3:Browse the jenkins in localhost 
   
    login with jenkins credentials
	Dashboard-->Managejenkins-->plugins-->Availableplugins-->Install Terraform plugin:Install the Terraform binary
	Managejenkins-->tools-->configuring tools git,Terraform then apply
	
step4: Create a simple Terraform configuration to deploy an EC2 instance.

step5:Create jenkins pipline:Dashboard-->NewItem-->create the new jenkins-pipeline
step6:Write the jenkins pipeline script
      
    pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', credentialsId: '<CREDS>', url: 'https://github.com/sumeetninawe/tf-tuts'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Terraform apply') {
            steps {
                sh 'terraform apply --auto-approve'
            }
        }
        
     }
    }
step7:Configure access to AWS
      Configure access to AWS: Configure AWS credentials in Jenkins. You can do this by navigating to the Jenkins dashboard, then Manage Jenkins > Manage Credentials. Under the Stores scoped to Jenkins section, select Jenkins.

step8:Test the jenkins pipeline

step9:use jenkins to destroy the infrastructure
