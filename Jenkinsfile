#!groovy

pipeline {
    agent any
    
    environment {
   	DOCKER_COMMON_CREDS = credentials("credentialsId")
    }

    tools {
        maven "3.6.0" // You need to add a maven with name "3.6.0" in the Global Tools Configuration page
    }
    
    triggers {
    	githubPush()
    }

    stages {
        stage("Build") {
            steps {
                sh "mvn -version"
                sh "mvn clean package -Dmaven.test.skip=true"
            }
        }
        
        stage('Build Docker Image'){
	     steps {
     		 sh "docker build -t saurabh1deshmukh/assignment-discovery-server:1.0.0 ."
	     }
   		}
   		
   		stage("Push Docker Image"){
			steps {
				sh "docker login -u ${DOCKER_COMMON_CREDS_USR} -p ${DOCKER_COMMON_CREDS_PSW}"
				sh "docker push saurabh1deshmukh/assignment-discovery-server:1.0.0"
			}
   		}
   		
   		stage("Deploy to Docker Environment"){
			steps {
				sshagent(["aws-cred"]) {
					sh "sudo chmod 666 /var/run/docker.sock"
   					sh "ssh -o StrictHostKeyChecking=no ubuntu@ec2-13-234-119-123.ap-south-1.compute.amazonaws.com docker run -d -p 8761:8761 --name assignment-discovery-server saurabh1deshmukh/assignment-discovery-server:1.0.0"
				}
			}
   		}
    }
    
    post {
        always {
            cleanWs()
        }
    }
}
