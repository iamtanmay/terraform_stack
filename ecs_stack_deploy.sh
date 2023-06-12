aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://templates/${STACK_NAME}.yml
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME
