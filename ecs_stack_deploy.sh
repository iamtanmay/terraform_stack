aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://templates/${STACK_NAME}_infra.yml --capabilities CAPABILITY_IAM
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
aws cloudformation create-stack --stack-name $STACK_NAME"-SERVICE" --template-body file://templates/${STACK_NAME}_deploy.yml --parameters  ParameterKey=StackName,ParameterValue=$StackName ParameterKey=ImageUrl,ParameterValue=$ECR_URI:latest  --capabilities CAPABILITY_IAM
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
