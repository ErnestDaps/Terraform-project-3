[![Board Status](https://dev.azure.com/ernestdaps/63a9a2cb-cf6c-4737-b6a1-0a44fc05927c/c70a1c3f-75f2-4dee-bef0-80dacc971a11/_apis/work/boardbadge/0dfd13ab-37ce-4149-bf98-7b9eebb0a23f)](https://dev.azure.com/ernestdaps/63a9a2cb-cf6c-4737-b6a1-0a44fc05927c/_boards/board/t/c70a1c3f-75f2-4dee-bef0-80dacc971a11/Microsoft.RequirementCategory)
# Terraform-project-3

# Project Description 

In this project, I've created a secure networking for an ongoing project using the AWS platform. It consists of 4 subnets spanning across two AZs. Two route tables have been created and associated with the public and private subnets. An internet gateway has been created and associated with the public route table. A Nat gateway has been placed in one of the public subnets and has been associated with the private route table to ensure updating, patching, etc of the contents in the private subnets. Security groups have been created with port 22 and 80 opened for ingress. 

Two EC2 instances have been created, one in the public subnet and the other in the private subnet and have been distributed across two AZs. A role has been assigned to the instance in the public subnet to allow Ansible to upload Apache web on it. 

  

# Project Execution 

The project was executed using terraform. The structure consists of a folder (Terraform-Project-3), within which are seven files namely; provider.tf, main.tf, EC2.tf, SG.tf, iam.tf, .gitignore and variable.tf. 

The provider.tf defines the cloud provider which is AWS.  

The main.tf contains the codes used in building the VPC (the networking).  

The variable.tf contains a declared input variables which give colleagues and other users the option to customise aspects of this module without altering the source code.  

The EC2.tf contains the codes for the two servers.  

SG.tf file houses the codes for the security groups. 

The iam.tf file contains the codes that defines the the assigned to the instance in the public subnet. 

The .gitignore file contains the list of restricted files that I don't want to push into the repo. 
