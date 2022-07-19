//Jenkinsfile (Declarative Pipeline)
pipeline {
    agent { label 'docker-agent' }
    environment {
        //TF_LOG='DEBUG'
        TF_LOG_PATH='/home/jenkins/terraform-debug.log'
        //Keep these all in lowercase
        CONTAINER_REGISTRY='arcticacr'
        RESOURCE_GROUP='jactt'
        REPO='jactt'
        IMAGE_NAME='template'
        TAG='0.01'
        CONTAINER='${CONTAINER_REGISTRY}.azurecr.io/${REPO}/${IMAGE_NAME}:${TAG}'
        NETWORKPART='10.127'
    }
    
    stages {
        stage('build') {
            steps {
                sh 'docker build -t ${CONTAINER} -f Dockerfile .'
                sh 'echo built ${CONTAINER}'
                
                withCredentials([
                    usernamePassword(credentialsId: 'sftpServicePrincipalCreds', passwordVariable: 'TF_VAR_clientsecret', usernameVariable: 'TF_VAR_clientid'),
                    usernamePassword(credentialsId: 'AzureTenantSubscription', passwordVariable: 'TF_VAR_tenantid', usernameVariable: 'TF_VAR_subscriptionid'),
                    usernamePassword(credentialsId: 'passwordtestCreds', passwordVariable: 'TEST_PASSWORD', usernameVariable: 'TEST_USERNAME')
                ]) {
                    //script{
                    //env.AZURE_SUBSCRIPTION_ID = env.TF_VAR_subscriptionid
                    //env.AZURE_TENANT_ID = env.TF_VAR_tenantid
                    //}
                     
                    //You can build the image on the Azure servers this way, if you want.
                    //sh 'az login --service-principal -u $TF_VAR_clientid -p $TF_VAR_clientsecret -t $TF_VAR_tenantid'
                    //sh 'az account set -s $TF_VAR_subscriptionid'
                    //sh 'az acr login --name $CONTAINER_REGISTRY --resource-group $RESOURCE_GROUP'
                    //sh 'az acr build --image $REPO/$IMAGE_NAME:$TAG --registry $CONTAINER_REGISTRY --file Dockerfile . '
                    //sh 'az logout'
                    
                    sh 'az login --service-principal -u $TF_VAR_clientid -p $TF_VAR_clientsecret -t $TF_VAR_tenantid'
                    //sh 'az account set -s $TF_VAR_subscriptionid'                                     //not necessary
                    //sh 'az acr login --name $CONTAINER_REGISTRY --resource-group $RESOURCE_GROUP'     //not necessary
                    sh 'az acr login --name $CONTAINER_REGISTRY'
                    sh 'docker push ${CONTAINER}'
                    sh 'az logout'
                    
                    sh 'terraform init'
                    sh 'terraform fmt'
                    sh 'terraform validate'
                    
                    sh 'terraform apply -auto-approve -no-color -var testpassword=$TEST_PASSWORD -var container=$CONTAINER -var networkpart=$NETWORKPART'
     
                    sh 'terraform show'
                    sh 'terraform state list'
                    //sh 'terraform import azurerm_lb.sftptestloadbalancer /subscriptions/$AZURE_SUBSCRIPTION_ID/resourceGroups/sftpResourceGroup/providers/Microsoft.Network/loadBalancers/sftptestloadbalancer'
                        }
            }
        }
    }
}
