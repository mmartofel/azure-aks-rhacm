
terraform init
terraform plan -var="subscription_id=$SUBSCRIPTION"
terraform apply -var="subscription_id=$SUBSCRIPTION"