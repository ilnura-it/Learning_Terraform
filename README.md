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

