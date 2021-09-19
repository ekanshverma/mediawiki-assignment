# mediawiki-assignment
## Getting Started
This repo gives detailed instructions for people who want to run MediaWiki on Red Hat Enterprise Linux or a RHEL-rebuild distribution such as CentOS or Oracle Linux using Terraform and Ansible by just changing the variables accordingly and apply!

### Prerequisites
1. Install Terraform version >=13
2. Install Ansible
3. AWS credentials in case of local machine, or use IAM Role in ec2. I used AWS Profile method to authenticate.
4. Private Key of ec2 instance

### Installation
1. Clone this repo.

2. Change the terraform.tfvars variables and provider.tf files accordingly. I have used s3 bucket to store the tfstate file securely with encryption, and used DynamoDB locking table.

3. Create encrypted mysql root user password and wiki user password using Ansible Vault. Create your Ansible Vault password which will be used later during terraform apply when ansible playbook will run.

```shell
ansible-vault encrypt_string '<your-password>' --name 'mysql_root_password'
ansible-vault encrypt_string '<your-password>' --name 'mysql_wiki_password'
```
Store their output in ansible/vars.yml

![Screenshot from 2021-09-19 20-43-35](https://user-images.githubusercontent.com/47328709/133932751-19dd0d80-8aa0-4ebc-8b8d-58437eb54569.png)

4. Initialize the Terraform

```shell
terraform init
```

5. Running Terraform Apply

```shell
terraform apply
```
Enter your Ansible Vault password.

![Screenshot from 2021-09-19 20-49-25](https://user-images.githubusercontent.com/47328709/133932969-84d03dd7-f005-4e4c-99ba-16a9402a31e2.png)

![Screenshot from 2021-09-19 20-50-08](https://user-images.githubusercontent.com/47328709/133932982-d32acd96-b80e-4387-b943-a8220db265b9.png)

![Screenshot from 2021-09-19 19-17-50](https://user-images.githubusercontent.com/47328709/133933005-27f102e3-613f-494a-8a8e-62453873a1c5.png)

![Screenshot from 2021-09-19 19-20-24](https://user-images.githubusercontent.com/47328709/133933022-3c781e53-0e2c-4796-99a7-025fd598248e.png)

![Screenshot from 2021-09-19 19-21-56](https://user-images.githubusercontent.com/47328709/133933032-1446c736-2501-4046-b915-c2d32e39f04c.png)




