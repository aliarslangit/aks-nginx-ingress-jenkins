pipeline {
   agent any
    stages {
        stage('Git checkout') { 
            steps{
                sh 'whoami'
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/aliarslangit/aks-nginx-jenkins.git'
            }
        }
    stage('Installing Azure Modules/CLI') {
            steps {
                    sh 'bash scripts/azcli.sh'
                }
        }
 
    stage('Connect to Aks') {
            steps {
    
                    withCredentials([azureServicePrincipal('azcli')]) {
                    sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'
                    }
                    sh "az aks get-credentials --resource-group rg-demo --name demo-aks"
                }
        }  

        //Install kubectl, Ingress and Helm if not already Installed

            stage('Installing Helm, Kubectl & ingress') {
             steps {
                    
                    sh 'bash scripts/helm.sh'
                    sh 'bash scripts/kubectl.sh'
                    sh 'bash scripts/ingress.sh'                  
                }
         }

       stage('Deploying application')
       {
           steps{
               sh 'kubectl apply -f ./Kubernetes/demoapp1.yaml --namespace ingress-basic'
               sh 'kubectl apply -f ./Kubernetes/demoapp2.yaml --namespace ingress-basic'
               sh 'kubectl apply -f ./Kubernetes/ingress-routes.yaml --namespace ingress-basic'
               sh 'kubectl get ingress -n ingress-basic'
               
               }
       }
    }
}
