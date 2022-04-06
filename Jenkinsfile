pipeline {
   agent any
    
  environment {
        docker=credentials('docker')
        registry = "aliarslanmushtaq/nodejs-microservice"
        registryCredential = 'docker'
        dockerImage = ''
    }
  
    parameters {
       
        string(name: 'temp', defaultValue: 'temp', description: '')

    }
    stages {
        stage('Git checkout') { 
            steps{
                sh 'whoami'
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/aliarslangit/Nodejs-aks-jenkins.git'
        }
        }
    stage('Installing Azure Modules') {
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

    stage('Build Docker Image')
        {
            steps{
                    sh 'sudo docker build -t aliarslanmushtaq/nodejs-microservice:V'+"$BUILD_NUMBER"+ ' . '
                 }
        }
    stage('Docker Login')
        {
            steps{
                    withCredentials([usernamePassword(credentialsId: 'docker', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'sudo docker login  -u $USERNAME -p $PASSWORD'
                }
        }
        }


       stage('Push image') {
           steps{
                    sh 'sudo docker push aliarslanmushtaq/nodejs-microservice:V' +"$BUILD_NUMBER"
                }
       }
       stage('Deploying application')
       {
           steps{
               sh 'kubectl apply -f ./kubernetes/hellochart/templates/deployment.yaml --namespace ingress-basic'
               sh 'kubectl apply -f ./kubernetes/hellochart/templates/service.yaml --namespace ingress-basic'
               sh 'kubectl apply -f ./kubernetes/hellochart/templates/ingress.yaml --namespace ingress-basic'
               //sh 'helm install example ./kubernetes/hellochart --namespace ingress-basic'
           }
       }
    }
}
