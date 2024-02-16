# Terraform

## Terraform commands

- Initialize terraform

      terraform init

- Validate

      terraform validate

- Create a plan

      terraform plan
- Create a plan with a name "myplan"
   
      terraform plan -out myplan 

- Apply the plan

      terraform apply myplan
      terraform apply -auto-approve

- Destroy resources

      terraform destroy myplan

- Formatting the code

      terraform format
      terraform fmt

- Check the version and see providers are installed

      terraform version

- Shows which providers are required by our configuration

      terraform providers


## Mulriple ways to provide credentials to interact with the provider

- 1. Put **access_key** and **secret_key** right inside of our provider block. ***NOT RECOMMENDED***

- 2. Use environment variables in therminal:

      export AWS_ACCESS+KEY="EXAMPLE&***"
      export AWS_SECRET_KEY="KJADKAHDKAHDKAJHDKAHD"

- 3. Set credentials inside of our provider with configuration file

            provider "aws" {
                region = "us-east-1"
                shared_credential_file = "/user/aws/.aws/creds
            }

## Terraform Output block
- To get the output:

            terraform output

- To get the output in JSON format:

            terraform output -json


## Commenting in Terraform

            #

            //
            
            /*    */

## Using multiple providers

- To see all installed providers

            terrform version

- To initialize the providers plugins

            terrform init
            terrfarom init -upgrade

## Terraform provisioners

Provisioners can be used to model specific actions on the local machine or on a remote machine in order to prepare servers or other infrastructure objects for service.

            provisioner "local-exec" {
            command = "chmod 400 ${local_file.private_key_pem.filename}"
            }

            provisioner "remote-exec" {
              inline = [
                "sudo rm -rf /tmp",
                "sudo git clone https://github.com/hashicorp/demo-terraform-101 /tmp",
                "sudo sh /tmp/assets/setup-web.sh",
              ]
            }

- Showcase state of an instance we created

            terraform state show aws_instance.ubuntu_server

## Auto Formatting TF code

            terraform fmt


## Replace Resources using Terraform Taint  

Mark a resource instance as not fully functional (will be replaced/rebuilt)

- To see the list of built resources

                  terrafotm state list

- choose resource

                  terraform taint aws_instance.ubuntu_server

                  terraform plan

- will recreate ubuntu_server as it was tainted

- to untaint

                  terraform taint aws_instance.ubuntu_server

#### Alternative Commans

- When run next execution sequence, replace resource

            terraform apply -replace="aws_instance.ubuntu_server"

## Terraform Import

Importing existing resources (f.e. is they were manually created)       

In order to start the import, our main.tf requires a provider configuration. Start off with a provider
block with a region in which you manually built the EC2 instance.

            provider "aws" {
            region = "us-west-2"
            }

You must also have a destination resource to store state against. Add an empty resource block now.
We will add an EC2 instance called “aws_linux”.

            resource "aws_instance" "aws_linux" {}

Now run a command to import

            terraform import aws_instance.aws_linux i-0bfff5070c5fb87b6

Our resource now exists in our state. If we run ***tf plan*** and see errors, it means we’re missing some required attributes. How can we find those without looking at the console? 

            terraform state show aws_instance.aws_linux

Using the output from the above command, we can now piece together the minimum required attributes for our configuration. Add the required attributes to your resource block and rerun the apply.

            resource "aws_instance" "aws_linux" {
                  ami = "ami-013a129d325529d4d"
                  instance_type = "t2.micro"
            }

## Terraform Workspaces - OSS

Workspaces is a Terraform feature that allows us to organize infrastructure by environments and
variables in a single directory.

            terraform workspace show
            # default

            terraform workspace -help

 Create a new Terraform Workspace for Development State

            terraform workspace new development

            terraform workspace show
            # development

            terraform workspace list
            # default
            # * development //means that development is selected

            terraform show
            # No state

            terraform workspace select default

## Debugging Terraform

Terraform has detailed logs which can be enabled by setting the TF_LOG environment variable to any
value. This will cause detailed logs to appear on stderr.
You can set TF_LOG to one of the log levels TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs, with TRACE being the most verbose.

### : Enable Logging 

- Linux
```export TF_LOG=TRACE```

- PowerShell
```$env:TF_LOG="TRACE"```

Run Terraform Apply
```terraform apply```

### Enable Logging Path

To persist logged output you can set TF_LOG_PATH in order to force the log to always be appended to a specific file when logging is enabled. Note that even when TF_LOG_PATH is set, TF_LOG must be set in order for any logging to be enabled.

- Linux
```export TF_LOG_PATH="terraform_log.txt"```

- PowerShell
```$env:TF_LOG_PATH="terraform_log.txt"```

- Run terraform init to see the initialization debugging information.
```terraform init -upgrade```

### Disable Logging

Terraform logging can be disabled by clearing the appropriate environment variable.

- Linux
```export TF_LOG=""```

- PowerShell
```$env:TF_LOG=""```

### Implement and Maintain State

Terraform State Locking

```terraform apply -lock-timeout=60s```

Install the latest module and provider versions allowed within configured constraints, overriding the default behavior of selecting exactly the version recorded in the dependency lockfile.
```terraform init -upgrade```

Reconfigure a backend, ignoring any saved configuration.
```terraform init  -reconfigure```

Reconfigure a backend, and attempt to migrate any existing state (local, remote, s3).
```terraform init -migrate-state```

### Terraform Cloud

```terraform login```

### Terraform State Refresh

Run a terraform refresh command to update Terraform state
```terraform refresh```

Automatically applying the effect of a refresh is risky, because if you have misconfigured credentials for one or more providers then the provider may be misled into thinking that all of the managed objects have been deleted, and thus remove all of the tracked objects without any confirmation prompt. This is is why the terraform refresh command has been deprecated. 
Instead it is recommended to use the ```-refresh-only``` option to get the same effect as a terraform refresh but with the opportunity to review the the changes that Terraform has detected before committing them to the state.
 
      ```terraform plan -refresh-only```
      ```terraform apply -refresh-only```

Will update terraform state file.

### Terraform Backend Configuration

      ```tf init -backend-config=path -migrate-state```   

Configuration to be merged with what is in the configuration file's 'backend' block. This can be either a path to an HCL file with key/value assignments (same format as terraform.tfvars) or a 'key=value' format, and can be specified multiple times. The backend type must be in the configuration itself.