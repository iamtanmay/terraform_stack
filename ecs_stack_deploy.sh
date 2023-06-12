aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://templates/${STACK_NAME}.yml
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://templates/${STACK_NAME}_deploy.yml --parameters ParameterKey=ImageUrl,ParameterValue=$ECR_URI:latest
