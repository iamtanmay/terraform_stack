export RAW_STR=$(awslocal ecr create-repository --repository-name test-ecr | grep "repositoryUri")
ECR_URI=(${RAW_STR//:/})
ECR_URI=${ECR_URI[1]}
export ECR_URI=$(echo ${ECR_URI}|sed 's/"//g'|sed 's/,//g')
echo "New ECR created: $ECR_URI"
cd ..
git clone https://github.com/thedevs-network/kutt.git
cd kutt
docker build -t ECR_URI .
