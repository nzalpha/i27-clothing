// Jenkinsfile to build and deploy the apps to various environments 
// Jenkinsfile to deploy our react based applications
pipeline {
   agent {
        label 'K8-slave'
    }
    tools {
        // maven 'mvn 3.8'
        jdk 'jdk-17'
    }

environment {
        APPLICATION_NAME = "clothing"
        AREA = "dev"
        // POM_VERSION = readMavenPom().getVersion()
        // POM_PACKAGING = readMavenPom().getPackaging()
        DOCKER_HUB= "docker.io/nawaz004"
        DOCKER_CREDS= credentials('docker_cred')
    }


parameters {
        choice (name: 'buildOnly', choices: 'no\nyes', description: "Only Build")
        choice (name: 'DockerPushOnly', choices: 'no\nyes', description: "Only Push to registry")
        // choice (name: 'DeploytoDev', choices: 'no\nyes', description: "Only deploy to dev")
        // choice (name: 'DeploytoTest', choices: 'no\nyes', description: "Only deploy to test")
        // choice (name: 'DeploytoStage', choices: 'no\nyes', description: "Only deploy to stage")
        // choice (name: 'DeploytoProd', choices: 'no\nyes', description: "Only deploy to prod")

    }


    stages {
        stage ('Build') {
            // This step will take care of building the application
            steps {
                echo "Build"
            }
        }
    

        stage("Docker build and Push")
        {

            steps{
                echo "Docker Build and push method"
                sh "docker build -t ${env.DOCKER_HUB}/${env.APPLICATION_NAME}:${GIT_COMMIT} ."
                echo "BuildDone"
                echo "-----------Docker Login--------------"
                sh "docker login -u ${env.DOCKER_CREDS_USR} -p ${env.DOCKER_CREDS_PSW}"
                echo "-------------Docker Push-----------"
                 sh "docker push ${env.DOCKER_HUB}/${env.APPLICATION_NAME}:${GIT_COMMIT}"
        }

        }

        stage("Deploy to Dev")
        {
            steps{
                echo "Deploy to Dev"
                withCredentials([usernamePassword(credentialsId: 'ali_docker_vm_cred', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
                
                echo "inside the script"
                script{
                 sh "sshpass -p ${PASSWORD} ssh -o StrictHostKeyChecking=no ${USERNAME}@${docker_server_ip} docker run -P --name ${env.APPLICATION_NAME}-${env.AREA} ${env.DOCKER_HUB}/${env.APPLICATION_NAME}:${GIT_COMMIT}"
                }
                }
            }
        }


    }
}

