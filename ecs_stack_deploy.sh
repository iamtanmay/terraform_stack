#Infra
aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://templates/${STACK_NAME}_infra.yml --capabilities CAPABILITY_IAM
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME

#Redis
aws cloudformation create-stack --stack-name $STACK_NAME"-Redis" --template-body file://templates/elasticache_redis.yml  --parameters  ParameterKey=StackName,ParameterValue=$STACK_NAME --capabilities CAPABILITY_IAM
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME"-Redis"

#Postgres
aws cloudformation create-stack --stack-name $STACK_NAME"-Postgres" --template-body file://templates/postgres.yml ParameterKey=StackName,ParameterValue=$STACK_NAME --capabilities CAPABILITY_IAM
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME"-Postgres"

#Kutt
aws cloudformation create-stack --stack-name $STACK_NAME"-SERVICE" --template-body file://templates/${STACK_NAME}_deploy.yml --parameters  ParameterKey=StackName,ParameterValue=$STACK_NAME ParameterKey=ImageUrl,ParameterValue=$ECR_URI:latest  --capabilities CAPABILITY_IAM
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME"-SERVICE"

export CLUSTER_ARN=$(aws ecs list-clusters | jq -r '.clusterArns[0]')
export TASK_ARN=$(aws ecs list-tasks --cluster $CLUSTER_ARN | jq -r '.taskArns[0]')
aws ecs describe-tasks --cluster $CLUSTER_ARN --tasks $TASK_ARN | jq -r '.tasks[0].containers[0].networkBindings[0].hostPort'
