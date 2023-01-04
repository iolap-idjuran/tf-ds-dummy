# ABOUT TF DS DUMMY

AWS IBM DataStage Platform - Terraform

4 tier App Design ( => _n_ Tier )

1. Metadata Repository
2. Services Tier
3. Engine tier
4. Compute Tier

# DESIGN

## Constructs

### High Level Constructs

- _Orchestration Pipelines (Jenkins?)_
- [ BASH ] Scripts
    - init.sh

### Low Level Constructs

- Terraform Modules
    - module template
    - modules:
        - __open_network__

            Base networking with low network restrictions 

        - __public_ec2_instance__
        
            Base EC2 instance with public access

        - __auto_scaling_group__
        
            Base EC2 Auto Scaling group 
        
        - __ssm_ec2_runbook__

            Base runbook for EC2 instance configuration/management

        - __enterprise_alarm__

            Monitoring with alerting capabilities
        
## Capabilities

# USAGE

## Requirements
- AWS CLI
- Terraform v?

## AWS Profile

For now, [AWS CLI profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) is required to bootstrap AWS environment and deploy solutions.

```sh
aws configure <profile-name>
```

## init script

Init script bootstraps Terraform on AWS (state bucket) and executes Terraform plan, show and deploy

```sh
./init.sh <aws-profile-name>
```

# CONTRIBUTION

# HELP
- [Terraform AWS Get Started](https://youtu.be/bStIFxbD1fo)

