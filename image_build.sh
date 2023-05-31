export RAW_STR=$(awslocal ecr create-repository --repository-name test-ecr | grep "repositoryUri")
echo "$RAW_STR"
export ECR_URI=(${RAW_STR//:/})
export ECR_URI=${ECR_URI[1]}
export ECR_URI=$(echo ${RAW_STR}|sed 's/"//g'|sed 's/,//g')
cd ..
git clone https://github.com/thedevs-network/kutt.git
cd kutt
docker build -t ECR_URI .
