#!/bin/bash

# init script
# Usage: ./init.sh <aws-profile>

#------------------- START PARMAMETRS -------------------#



#--------------------- STOP PARMAMETRS ------------------#


#----------------------- TESTS START ----------------------#
# test if arg exists
if [ -z "$1" ]
then
    echo -e "No argument supplied\nUsage: ./init.sh <aws-profile>"
    exit 1
else
    aws_profile_name="$1"

    # if profile is valid
    if ! [[ aws --profile $aws_profile_name sts get-caller-identity ]]
    then 
        echo "AWS profile not valid - reconfigure the profile"
        aws configure --profile $aws_profile_name
fi
fi

# test if aws cli is available
if ! [[ $(aws --version) ]]
then
    echo "aws cli not installed"
    exit 1
fi

#---------------------- TESTS STOP ----------------------#


#------------------------ AWS START -----------------------#
# deploy cfn template
cfn_stack_name="tf-core-stack"

aws --profile "$aws_profile_name" cloudformation deploy \
    --stack-name $cfn_stack_name \
    --template-file aws-bootstrap/tf-base.yml

# get tf state bucket name 
tf_state_bucket_name=$(aws --profile $aws_profile_name \
                            cloudformation describe-stacks \
                            --stack-name $cfn_stack_name \
                            --query "Stacks[0].Outputs[?OutputKey=='OutTfStateBucketName'].OutputValue" \
                            --output text
                            )
#----------------------- AWS STOP -----------------------#


#--------------------- TERRAFORM START --------------------#
# init tf
cd terraform
terraform init \
    -backend-config="bucket=$tf_state_bucket_name" \
    -backend-config="profile=$aws_profile_name"

# plan tf
terraform plan

# show terraform
terraform show

# apply tf
terraform apply
#-------------------- TERRAFORM STOP --------------------#