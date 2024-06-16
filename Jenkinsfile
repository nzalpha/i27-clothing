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
        // POM_VERSION = readMavenPom().getVersion()
        // POM_PACKAGING = readMavenPom().getPackaging()
        DOCKER_HUB= "docker.io/nawaz004"
        DOCKER_CREDS= credentials('docker_cred')
    }


parameters {
        choice (name: 'buildOnly', choices: 'no\nyes', description: "Only Build")
        choice (name: 'DockerPushOnly', choices: 'no\nyes', description: "Only Push to registry")
        choice (name: 'DeploytoDev', choices: 'no\nyes', description: "Only deploy to dev")
        choice (name: 'DeploytoTest', choices: 'no\nyes', description: "Only deploy to test")
        choice (name: 'DeploytoStage', choices: 'no\nyes', description: "Only deploy to stage")
        choice (name: 'DeploytoProd', choices: 'no\nyes', description: "Only deploy to prod")

    }


    stages {
        stage ('Build') {
            when{
                anyOf{
                    expression{
                        params.buildOnly == 'yes'
                    }
                }
            }


            // This step will take care of building the application
            steps {
                echo "Build"
            }
        }
    

        stage("Docker build and Push")
        {
            when{
                anyOf{
                    expression{
                        params.DockerPushOnly == 'yes'
                    }
                }
            }
            steps{
                 echo "Docker Build"
                script{
                    dockerBuildAndPush().call()
                }
                
            }
        }

}
}


dockerBuildAndPush(){
    return{
         echo "Docker Build and push method"
        sh "docker build -t nzimg:v1"
        echo "BuildDone"
        sh "docker images"
    }
}